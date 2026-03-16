$path = "d:\Terragen\360Panorama_Marzipano\clone\TatraMts_LGM_landscape\data.js"
$text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$replacements = @(
  @("MiÄ™", "Mięt"),
  @("MaĹ‚", "Mał"),
  @("JagniÄ™", "Jagnię"),
  @("gĂłra", "góra"),
  @("BiaĹ‚kÄ…", "Białką"),
  @("GÄ™sia", "Gęsia"),
  @("ĹšwistĂłwka", "Świstówka"),
  @("GubaĹ‚Ăłwka", "Gubałówka"),
  @("PrzeĹ‚Ä™cz", "Przełęcz"),
  @("PiÄ™Ä‡", "Pięć")
)

foreach ($pair in $replacements) {
  $text = $text.Replace($pair[0], $pair[1])
}

[System.IO.File]::WriteAllText($path, $text, [System.Text.Encoding]::UTF8)
Write-Host "fixed"
