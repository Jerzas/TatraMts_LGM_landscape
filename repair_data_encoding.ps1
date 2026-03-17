$ErrorActionPreference = 'Stop'

$path = Join-Path $PSScriptRoot 'data.js'
$backupPath = Join-Path $PSScriptRoot 'data.encoding_repair.bak.js'

if (-not (Test-Path $path)) {
  throw "Missing file: $path"
}

$text = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
[System.IO.File]::WriteAllText($backupPath, $text, [System.Text.Encoding]::UTF8)

$doubleEscapedQuote = [string]([char]92) + [char]92 + [char]34
$singleEscapedQuote = [string]([char]92) + [char]34
$text = $text.Replace($doubleEscapedQuote, $singleEscapedQuote)

$cp1250 = [System.Text.Encoding]::GetEncoding(1250)
$utf8 = [System.Text.Encoding]::UTF8
$pattern = '"(?:\\.|[^"\\])*"'
$mojibakeMarker = '[\u0102\u00C3\u00C4\u00C5\u0139\u013D\u011A\u010E\u0118\u0106\u02C7\u02DB\u02DD\u201A\u201E\u2026]'

$changed = 0
$fixed = [regex]::Replace($text, $pattern, {
  param($m)

  $token = $m.Value
  $inner = $token.Substring(1, $token.Length - 2)

  if ($inner -notmatch $mojibakeMarker) {
    return $token
  }

  $bytes = $cp1250.GetBytes($inner)
  $decoded = $utf8.GetString($bytes)

  if ($decoded -match '\uFFFD') {
    return $token
  }

  $origMarkerCount = ([regex]::Matches($inner, $mojibakeMarker)).Count
  $newMarkerCount = ([regex]::Matches($decoded, $mojibakeMarker)).Count
  if ($newMarkerCount -ge $origMarkerCount) {
    return $token
  }

  $script:changed++
  $escaped = $decoded.Replace('\', '\\').Replace('"', '\"')
  return '"' + $escaped + '"'
})

[System.IO.File]::WriteAllText($path, $fixed, [System.Text.Encoding]::UTF8)

Write-Host "backup=$backupPath"
Write-Host "fixed_strings=$changed"