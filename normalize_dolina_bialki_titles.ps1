$path = "d:\Terragen\360Panorama_Marzipano\clone\TatraMts_LGM_landscape\data.js"
$text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

$start = $text.IndexOf('"id": "5-dolina-biaki"')
if ($start -lt 0) { throw 'Scene 5-dolina-biaki not found.' }
$end = $text.IndexOf('"id": "6-krzyne"', $start)
if ($end -lt 0) { throw 'Next scene marker not found.' }

$segment = $text.Substring($start, $end - $start)

$map = [ordered]@{
  'link świnica' = 'Link: Świnica'
  'Link velka Kopa' = 'Link: Veľká kopa'
  'link koprowa' = 'Link: Kôprová dolina'
  'Link Morskie Oko' = 'Link: Morskie Oko'
  'Link koprowy' = 'Link: Kôprovský štít'
  'Link batizovska&nbsp;' = 'Link: Batizovská dolina'
  'Link hruba veza' = 'Link: Hrubá veža'
  'link swistowy' = 'Link: Svišťový štít'
  'link salvkovsky' = 'Link: Slavkovský štít'
  'Link huncovsky' = 'Link: Huncovský štít'
  'link łomnicky' = 'Link: Lomnický štít'
  'link Czerwone wierchy' = 'Link: Czerwone Wierchy'

  'Javoroy glacier' = 'Javorový glacier'
  'Siroky glacier' = 'Široká glacier'
  'Goły Wierch' = 'Goły Wierch 1206'
  'Lubań' = 'Lubań 1225'
  'Turbacz' = 'Turbacz 1310'
  'Mogielica' = 'Mogielica 1170'
  'Jagniecy stit' = 'Jagnięcy Szczyt 2230'
  'Czarny stit' = 'Czarny Szczyt 2429'
  'Lomnicky stit' = 'Lomnický štít 2634'
  'kiezmarsky stit' = 'Kežmarský štít 2558'
  'Ladovy stit' = 'Ladový štít 2627'
  'Posredny hrot' = 'Prostredný hrot 2441'
  'ostry stit' = 'Ostry Szczyt 2360'
  'Javorovy stit' = 'Javorový štít 2418'
  'Siroka 2210' = 'Široká 2210'
  'Bradvica' = 'Bradavica 2476'
  'gerlachosvy stot' = 'Gerlachovský štít 2655'
  'Koncista' = 'Končistá 2538'
  'Batozovski stit' = 'Batizovský štít 2448'
  'Mlynar' = 'Mlynár 2170'
  'Vysoka' = 'Vysoká 2547'
  'Ganek' = 'Ganek 2459'
  'Rysy' = 'Rysy 2501'
  'Żabi Koń' = 'Żabi Koń 2291'
  '<h2>Bielovodská veža</h2>' = 'Bielovodská veža'
  '<h1>Żabia Czuba 2080</h1>' = 'Żabia Czuba 2080'
  'Zabi glacier' = 'Żabi glacier'
  'Zadnia kopa' = 'Zadnia Kopa'
  'Velky Babos' = 'Veľký Baboš'
  'Kicera' = 'Kiczera'
  'Belovodsky glacier' = 'Bielovodský glacier'
  'Hruba veza' = 'Hrubá veža'
  '<h2>Veža nad kolibou</h2>' = 'Veža nad kolibou'
  '<h1>Úplazky</h1>' = 'Úplazky'
  '<h1>Roztocka Czuba 1425</h1>' = 'Roztocka Czuba 1425'
  'Waksumundzki glacier' = 'Waksmundzki glacier'
  'krivan' = 'Kriváň 2494'
  'Świnica' = 'Świnica 2301'
  'Wielka Koszyta' = 'Wielka Koszysta 2193'
  'Kasprowy Wierch' = 'Kasprowy Wierch 1987'
  'Giewont' = 'Giewont 1894'
  'Mnich' = 'Mnich 2068'
  'Mieguszowiskic szczyt Wielki' = 'Mięguszowiecki Szczyt Wielki 2438'
  'Babia gora' = 'Babia Góra 1725'
  'Radziejowa' = 'Radziejowa 1262'
  'Jaworzyna Krynicka' = 'Jaworzyna Krynicka 1114'
  'C e r g o v' = 'Čergov'
  'Dumbier' = 'Ďumbier 2043'
  'Levocke vyrchy&nbsp;' = 'Levočské vrchy'
  'Spiska Magura' = 'Spišská Magura'
  'Gubałówka' = 'Gubałówka 1126'
  'Opalony wierch' = 'Opalony Wierch 2115'
  'Miedziane' = 'Miedziane 2233'
  'Kopske sedlo' = 'Kopské sedlo 1749'
  'Havran' = 'Havran 2152'
  'Paclive' = 'Páclivé'
  'Cervena dolina' = 'Červená dolina'
  'Waksmundszka Przełęcz' = 'Waksmundzka Przełęcz'
  'Filipka Valley' = 'Dolina Filipka'
  'Chovancov vyrch' = 'Chovanec'
  'Zamky' = 'Zámky'
  'Skrajny Wołoszyn' = 'Skrajny Wołoszyn 2168'
  'Morskie Oko will be here' = 'Morskie Oko'
}

foreach ($old in $map.Keys) {
  $new = $map[$old]
  $segment = $segment.Replace('"title": "' + $old + '"', '"title": "' + $new + '"')
}

$newText = $text.Substring(0, $start) + $segment + $text.Substring($end)
[System.IO.File]::WriteAllText($path, $newText, [System.Text.Encoding]::UTF8)
Write-Host 'done'
