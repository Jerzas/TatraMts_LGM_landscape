$ErrorActionPreference = 'Stop'

$dataJsPath = '.\data.js'
$listCsvPath = '.\_geo_ordered_list_validated_with_heights.csv'

if(-not (Test-Path $dataJsPath)){ throw "Missing $dataJsPath" }
if(-not (Test-Path $listCsvPath)){ throw "Missing $listCsvPath" }

$dataJs = Get-Content -Raw -Path $dataJsPath -Encoding UTF8
$listRows = Import-Csv -Path $listCsvPath -Encoding UTF8

function Normalize-Name([string]$s){
  if(-not $s){ return '' }
  $x = $s.Trim()
  $x = [regex]::Replace($x,'<[^>]+>','')
  $x = $x.Normalize([Text.NormalizationForm]::FormD)
  $sb = New-Object System.Text.StringBuilder
  foreach($ch in $x.ToCharArray()){
    if([Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch) -ne [Globalization.UnicodeCategory]::NonSpacingMark){
      [void]$sb.Append($ch)
    }
  }
  $x = $sb.ToString().ToLower()
  $x = [regex]::Replace($x,'[^a-z0-9 ]',' ')
  $x = [regex]::Replace($x,'\s+',' ').Trim()
  return $x
}

$rxTitle = [regex]'"title"\s*:\s*"([^"]+)"'
$rxName = [regex]'"name"\s*:\s*"([^"]+)"'
$rxH = [regex]'^(?<name>.*?)(?:\s+)(?<h>\d{3,4})(?:\s?m)?$'

$canon = @{}
$heightConflicts = @()

foreach($m in $rxTitle.Matches($dataJs)){
  $rawTitle = [regex]::Replace($m.Groups[1].Value,'<[^>]+>','').Trim()
  $namePart = $rawTitle
  $h = ''
  $mh = $rxH.Match($rawTitle)
  if($mh.Success){
    $namePart = $mh.Groups['name'].Value.Trim()
    $h = $mh.Groups['h'].Value
  }

  $key = Normalize-Name $namePart
  if(-not $key){ continue }

  if(-not $canon.ContainsKey($key)){
    $canon[$key] = [ordered]@{
      displayName = $namePart
      heights = @{}
      total = 0
    }
  }

  $canon[$key].total++
  if($h){
    if(-not $canon[$key].heights.ContainsKey($h)){
      $canon[$key].heights[$h] = 0
    }
    $canon[$key].heights[$h]++
  }
}

# include scene names as canonical names too (without forcing heights)
foreach($m in $rxName.Matches($dataJs)){
  $rawName = [regex]::Replace($m.Groups[1].Value,'<[^>]+>','').Trim()
  if(-not $rawName){ continue }
  $key = Normalize-Name $rawName
  if(-not $key){ continue }

  if(-not $canon.ContainsKey($key)){
    $canon[$key] = [ordered]@{
      displayName = $rawName
      heights = @{}
      total = 0
    }
  }
  $canon[$key].total++
}

# canonical height decision per key: most frequent, then higher value
$canonNameMap = @{}
foreach($k in $canon.Keys){
  $display = $canon[$k].displayName
  $chosenH = ''
  if($canon[$k].heights.Count -gt 0){
    $chosen = $canon[$k].heights.GetEnumerator() | Sort-Object @{Expression='Value';Descending=$true}, @{Expression={[int]$_.Name};Descending=$true} | Select-Object -First 1
    $chosenH = [string]$chosen.Name
  }

  # conflict report (same base name, multiple heights)
  if($canon[$k].heights.Count -gt 1){
    $heightConflicts += [pscustomobject]@{
      base_name = $display
      normalized_key = $k
      heights = (($canon[$k].heights.Keys | Sort-Object {[int]$_}) -join ', ')
      counts = (($canon[$k].heights.GetEnumerator() | Sort-Object Name | ForEach-Object { "$($_.Name):$($_.Value)" }) -join '; ')
      chosen_height = $chosenH
    }
  }

  $canonicalName = $display
  if($chosenH){
    $canonicalName = "$display $chosenH"
  }

  $canonNameMap[$k] = [pscustomobject]@{
    base_name = $display
    chosen_height = $chosenH
    canonical_name = $canonicalName
  }
}

# rebuild list names strictly from data.js canonical map
$updated = foreach($r in $listRows){
  $base = $r.name
  $mh = $rxH.Match($base)
  if($mh.Success){ $base = $mh.Groups['name'].Value.Trim() }
  $k = Normalize-Name $base
  $newName = $r.name
  $statusNote = ''
  if($canonNameMap.ContainsKey($k)){
    $newName = $canonNameMap[$k].canonical_name
  } else {
    $statusNote = 'name-not-found-in-datajs-titles'
  }

  [pscustomobject]@{
    rank = $r.rank
    name = $newName
    type = $r.type
    lon = $r.lon
    lat = $r.lat
    status = $r.status
    source = if($r.PSObject.Properties['source']){ $r.source } else { '' }
    note = $statusNote
  }
}

# similarity conflicts (different keys but very similar names)
function TokenSet([string]$s){
  if(-not $s){ return @() }
  return (Normalize-Name $s -split ' ' | Where-Object { $_.Length -gt 2 })
}

$keys = @($canonNameMap.Keys)
$similar = @()
for($i=0; $i -lt $keys.Count; $i++){
  for($j=$i+1; $j -lt $keys.Count; $j++){
    $a = $keys[$i]; $b = $keys[$j]
    if($a -eq $b){ continue }

    $ta = TokenSet $a
    $tb = TokenSet $b
    if($ta.Count -eq 0 -or $tb.Count -eq 0){ continue }

    $inter = @($ta | Where-Object { $tb -contains $_ })
    $unionCount = (@($ta + $tb | Select-Object -Unique)).Count
    if($unionCount -eq 0){ continue }
    $sim = [double]$inter.Count / [double]$unionCount

    if($sim -ge 0.7){
      $similar += [pscustomobject]@{
        name_a = $canonNameMap[$a].canonical_name
        name_b = $canonNameMap[$b].canonical_name
        similarity = [math]::Round($sim,3)
      }
    }
  }
}
$similar = $similar | Sort-Object similarity -Descending

# list-vs-datajs mismatches
$mismatch = $updated | Where-Object { $_.note -ne '' }

$updated | Export-Csv -Path .\_geo_ordered_list_validated_with_heights.csv -NoTypeInformation -Encoding UTF8
$updated | Format-Table rank,name,type,lon,lat,status -AutoSize | Out-String -Width 500 | Set-Content -Path .\_geo_ordered_list_pretty.txt -Encoding UTF8

$heightConflicts | Export-Csv -Path .\_conflicts_height_variants.csv -NoTypeInformation -Encoding UTF8
$similar | Select-Object -First 300 | Export-Csv -Path .\_conflicts_similar_names.csv -NoTypeInformation -Encoding UTF8
$mismatch | Export-Csv -Path .\_conflicts_names_not_in_datajs.csv -NoTypeInformation -Encoding UTF8

Write-Host ("canon_keys=" + $canonNameMap.Count)
Write-Host ("height_conflicts=" + $heightConflicts.Count)
Write-Host ("similar_name_conflicts=" + $similar.Count)
Write-Host ("list_names_missing_in_datajs=" + $mismatch.Count)
