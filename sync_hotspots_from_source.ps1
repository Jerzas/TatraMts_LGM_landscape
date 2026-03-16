$sourcePath = "d:\Terragen\360Panorama_Marzipano\Varia_panorama_Tatry_Oblazowa2\app-files\data.js"
$targetPath = "d:\Terragen\360Panorama_Marzipano\clone\TatraMts_LGM_landscape\data.js"

$ids = @("0-ornak", "1-ciemniak", "2-huncovsk-tt", "5-dolina-biaki", "6-krzyne")

$src = [System.IO.File]::ReadAllText($sourcePath, [System.Text.Encoding]::UTF8)
$dst = [System.IO.File]::ReadAllText($targetPath, [System.Text.Encoding]::UTF8)

function Find-MatchingBracket {
  param(
    [string]$text,
    [int]$openIndex
  )
  $depth = 0
  for ($i = $openIndex; $i -lt $text.Length; $i++) {
    $ch = $text[$i]
    if ($ch -eq '[') { $depth++ }
    elseif ($ch -eq ']') {
      $depth--
      if ($depth -eq 0) { return $i }
    }
  }
  return -1
}

function Extract-HotspotBlock {
  param(
    [string]$text,
    [string]$sceneId
  )

  $idToken = '"id": "' + $sceneId + '"'
  $idPos = $text.IndexOf($idToken)
  if ($idPos -lt 0) { throw "Scene not found in source: $sceneId" }

  $linkPos = $text.IndexOf('"linkHotspots"', $idPos)
  if ($linkPos -lt 0) { throw "linkHotspots not found in source: $sceneId" }

  $infoPos = $text.IndexOf('"infoHotspots"', $linkPos)
  if ($infoPos -lt 0) { throw "infoHotspots not found in source: $sceneId" }

  $infoArrOpen = $text.IndexOf('[', $infoPos)
  if ($infoArrOpen -lt 0) { throw "infoHotspots array open not found in source: $sceneId" }

  $infoArrClose = Find-MatchingBracket -text $text -openIndex $infoArrOpen
  if ($infoArrClose -lt 0) { throw "infoHotspots array close not found in source: $sceneId" }

  return $text.Substring($linkPos, $infoArrClose - $linkPos + 1)
}

function Replace-HotspotBlock {
  param(
    [string]$text,
    [string]$sceneId,
    [string]$newBlock
  )

  $idToken = '"id": "' + $sceneId + '"'
  $idPos = $text.IndexOf($idToken)
  if ($idPos -lt 0) { throw "Scene not found in target: $sceneId" }

  $linkPos = $text.IndexOf('"linkHotspots"', $idPos)
  if ($linkPos -lt 0) { throw "linkHotspots not found in target: $sceneId" }

  $infoPos = $text.IndexOf('"infoHotspots"', $linkPos)
  if ($infoPos -lt 0) { throw "infoHotspots not found in target: $sceneId" }

  $infoArrOpen = $text.IndexOf('[', $infoPos)
  if ($infoArrOpen -lt 0) { throw "infoHotspots array open not found in target: $sceneId" }

  $infoArrClose = Find-MatchingBracket -text $text -openIndex $infoArrOpen
  if ($infoArrClose -lt 0) { throw "infoHotspots array close not found in target: $sceneId" }

  $before = $text.Substring(0, $linkPos)
  $after = $text.Substring($infoArrClose + 1)

  return $before + $newBlock + $after
}

foreach ($id in $ids) {
  $block = Extract-HotspotBlock -text $src -sceneId $id
  $dst = Replace-HotspotBlock -text $dst -sceneId $id -newBlock $block
  Write-Host "[OK] synced $id"
}

[System.IO.File]::WriteAllText($targetPath, $dst, [System.Text.Encoding]::UTF8)
Write-Host "Done."
