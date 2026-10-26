# Baut die Soccerpark-App als Web-App und kopiert sie nach .\app
#
# Aufruf (PowerShell, in diesem Ordner):
#   powershell -ExecutionPolicy Bypass -File .\build_app.ps1
#
# -Repo muss dem Namen des GitHub-Repositorys entsprechen, denn die Seite
# liegt unter https://<benutzer>.github.io/<Repo>/ und die App unter .../app/.

param(
  [string]$Repo = "soccerpark-test",
  [string]$Project = "D:\Flutter Apps\soccerpark_new"
)

$ErrorActionPreference = "Stop"
$site = $PSScriptRoot
$app = Join-Path $site "app"

Write-Host "Baue App fuer https://<benutzer>.github.io/$Repo/app/ ..."
Push-Location $Project
try {
  flutter pub get
  if ($LASTEXITCODE -ne 0) { throw "flutter pub get fehlgeschlagen" }
  flutter build web --release --base-href "/$Repo/app/"
  if ($LASTEXITCODE -ne 0) { throw "flutter build web fehlgeschlagen" }
} finally {
  Pop-Location
}

if (Test-Path $app) { Remove-Item $app -Recurse -Force }
Copy-Item (Join-Path $Project "build\web") $app -Recurse

# Test-App nicht in Suchmaschinen aufnehmen.
$index = Join-Path $app "index.html"
$html = [IO.File]::ReadAllText($index)
if ($html -notmatch 'name="robots"') {
  $html = $html -replace '<head>', "<head>`r`n  <meta name=""robots"" content=""noindex, nofollow"">"
  [IO.File]::WriteAllText($index, $html)
}

Write-Host ""
Write-Host "Fertig. Jetzt die Aenderungen committen und zu GitHub pushen."
