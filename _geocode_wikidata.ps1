$ErrorActionPreference = 'Continue'
Write-Host 'geocode script start'
$names = Get-Content .\_geo_names_clean.txt -Encoding UTF8 | Where-Object { $_ -and ($_ -notmatch '^<') } | Select-Object -Unique

function Get-CoordFromEntity($entityId) {
  $u = "https://www.wikidata.org/wiki/Special:EntityData/$entityId.json"
  $r = Invoke-RestMethod -Uri $u -Method Get -TimeoutSec 30
  if (-not $r.entities.$entityId.claims.P625) { return $null }
  $val = $r.entities.$entityId.claims.P625[0].mainsnak.datavalue.value
  return [pscustomobject]@{ lat = [double]$val.latitude; lon = [double]$val.longitude }
}

$results = @()
$i = 0
foreach($n in $names){
  $i++
  $coord = $null
  $label = $null
  $qid = $null
  foreach($lang in @('pl','sk','en')){
    $q = [uri]::EscapeDataString($n)
    $u = "https://www.wikidata.org/w/api.php?action=wbsearchentities&search=$q&language=$lang&format=json&limit=5"
    $resp = Invoke-RestMethod -Uri $u -Method Get -TimeoutSec 30
    if($resp.search){
      foreach($item in $resp.search){
        $c = Get-CoordFromEntity $item.id
        if($c){
          $coord = $c
          $label = $item.label
          $qid = $item.id
          break
        }
      }
    }
    if($coord){ break }
  }

  $type='other'
  if($n -match '(?i)glacier|lodowiec|cirque'){ $type='glacier' }
  elseif($n -match '(?i)dolina|valley|potok|river|basin'){ $type='valley/river' }
  elseif($n -match '(?i)wierch|stit|stit|turnia|kopa|bok|rysy|mnich|solisko|gora|nosal|giewont|veza|vrch|peak|mount'){ $type='peak/ridge' }

  $results += [pscustomobject]@{
    name = $n
    type = $type
    lat = if($coord){$coord.lat}else{$null}
    lon = if($coord){$coord.lon}else{$null}
    source = if($qid){"wikidata:$qid"}else{"scene-proximity-estimate"}
    matchedLabel = $label
  }

  if(($i % 25) -eq 0){ Write-Host "processed=$i" }
}

$results | ConvertTo-Json -Depth 4 | Set-Content .\_geo_coords_wikidata.json -Encoding UTF8
$resolved = ($results | Where-Object { $_.lon -ne $null }).Count
Write-Host "total=$($results.Count) resolved=$resolved unresolved=$($results.Count-$resolved)"
$sorted = $results | Sort-Object @{Expression='lon';Descending=$false}, @{Expression='lat';Descending=$true}
$sorted | ConvertTo-Json -Depth 4 | Set-Content .\_geo_sorted_w_e_ns.json -Encoding UTF8
$sorted | Select-Object -First 40 | Format-Table -AutoSize
Write-Host 'geocode script done'
