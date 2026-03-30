$dataJs = Get-Content -Raw -Path .\data.js -Encoding UTF8
$csvPath = '.\_geo_ordered_list.csv'
$rows = Import-Csv -Path $csvPath -Encoding UTF8

function Normalize-Name([string]$s){
  if(-not $s){ return '' }
  $x = $s.ToLower()
  $x = $x.Normalize([Text.NormalizationForm]::FormD)
  $sb = New-Object System.Text.StringBuilder
  foreach($ch in $x.ToCharArray()){
    $cat = [Globalization.CharUnicodeInfo]::GetUnicodeCategory($ch)
    if($cat -ne [Globalization.UnicodeCategory]::NonSpacingMark){
      [void]$sb.Append($ch)
    }
  }
  $x = $sb.ToString()
  $x = [regex]::Replace($x,'<[^>]+>','')
  $x = [regex]::Replace($x,'\s+\d{3,4}(?:\s?m)?$','')
  $x = [regex]::Replace($x,'[^a-z0-9 ]','')
  return ([regex]::Replace($x,'\s+',' ').Trim())
}

$heightMap = @{}
$rxTitle = [regex]'"title"\s*:\s*"([^"]+)"'
$rxH = [regex]'^(?<name>.*?)(?:\s+)(?<h>\d{3,4})(?:\s?m)?$'
foreach($m in $rxTitle.Matches($dataJs)){
  $title = $m.Groups[1].Value
  $title = [regex]::Replace($title,'<[^>]+>','').Trim()
  $mh = $rxH.Match($title)
  if(-not $mh.Success){ continue }
  $base = Normalize-Name $mh.Groups['name'].Value
  $h = [int]$mh.Groups['h'].Value
  if(-not $heightMap.ContainsKey($base)){ $heightMap[$base] = @{} }
  if(-not $heightMap[$base].ContainsKey($h)){ $heightMap[$base][$h] = 0 }
  $heightMap[$base][$h]++
}

function Get-BestHeight([string]$baseNorm){
  if(-not $heightMap.ContainsKey($baseNorm)){ return '' }
  $counts = $heightMap[$baseNorm].GetEnumerator() | Sort-Object @{Expression='Value';Descending=$true}, @{Expression='Name';Descending=$true}
  return [string]$counts[0].Name
}

$updated = foreach($r in $rows){
  $nameNorm = Normalize-Name $r.name
  $elev = Get-BestHeight $nameNorm
  [pscustomobject]@{
    rank = $r.rank
    name = $r.name
    type = $r.type
    lon = $r.lon
    lat = $r.lat
    status = $r.status
    source = $r.source
    elevation_m = $elev
  }
}

$updated | Export-Csv -Path $csvPath -NoTypeInformation -Encoding UTF8
$updated | ConvertTo-Json -Depth 4 | Set-Content .\_geo_ordered_list_with_elevation.json -Encoding UTF8
Write-Host ('rows=' + $updated.Count)
Write-Host ('with_elevation=' + (($updated | Where-Object { $_.elevation_m -ne '' }).Count))
$updated | Select-Object -First 30 | Format-Table -AutoSize
