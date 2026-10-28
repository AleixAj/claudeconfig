<#
  Instala este pack de configuracion de Claude Code. Equivalente a instalar.sh,
  para Windows sin bash.

    .\instalar.ps1                              -> en la carpeta actual
    .\instalar.ps1 -Proyecto C:\ruta\proyecto   -> en ese proyecto
    .\instalar.ps1 -Global                      -> en ~/.claude
    .\instalar.ps1 -Global -Forzar              -> sobrescribe lo que ya haya
    .\instalar.ps1 -Shopify                     -> ademas copia el CLAUDE.md del tema

  Por defecto NO sobrescribe nada.
#>
param(
  [switch]$Global,
  [switch]$Shopify,
  [switch]$Forzar,
  [string]$Proyecto
)

$ErrorActionPreference = 'Stop'
$Origen = $PSScriptRoot

if ($Global) {
  if ($Proyecto) { Write-Host "No puedes usar -Global y -Proyecto a la vez."; exit 1 }
  $Base = Join-Path $HOME '.claude'
  $Donde = "global ($Base)"
  $RaizProyecto = $null
} else {
  $RaizProyecto = if ($Proyecto) { (Resolve-Path $Proyecto).Path } else { (Get-Location).Path }
  $Base = Join-Path $RaizProyecto '.claude'
  $Donde = "este proyecto ($Base)"
}

Write-Host "Instalando en: $Donde"
Write-Host ""

New-Item -ItemType Directory -Force -Path (Join-Path $Base 'skills') | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $Base 'agents') | Out-Null

$nuevas = 0; $saltadas = 0
foreach ($d in Get-ChildItem -Path (Join-Path $Origen 'skills') -Directory) {
  $destino = Join-Path $Base "skills\$($d.Name)"
  if ((Test-Path $destino) -and (-not $Forzar)) {
    Write-Host "  ya existe, se salta   $($d.Name)"
    $saltadas++
    continue
  }
  if (Test-Path $destino) { Remove-Item -Recurse -Force $destino }
  Copy-Item -Recurse -Path $d.FullName -Destination $destino
  $nuevas++
}
Write-Host "  skills: $nuevas instaladas, $saltadas saltadas"

$ag = 0
foreach ($f in Get-ChildItem -Path (Join-Path $Origen 'agents') -Filter '*.md') {
  $destino = Join-Path $Base "agents\$($f.Name)"
  if ((Test-Path $destino) -and (-not $Forzar)) { continue }
  Copy-Item -Path $f.FullName -Destination $destino -Force
  $ag++
}
Write-Host "  agentes: $ag instalados"

# settings.json NUNCA se sobrescribe: puede tener permisos personales.
$settingsDestino = Join-Path $Base 'settings.json'
$settingsOrigen  = Join-Path $Origen 'settings.json'
if (Test-Path $settingsDestino) {
  $pack = Join-Path $Base 'settings.pack.json'
  Copy-Item -Path $settingsOrigen -Destination $pack -Force
  Write-Host ""
  Write-Host "  OJO: ya tenias settings.json, no lo he tocado."
  Write-Host "       Los permisos del pack estan en $pack"
  Write-Host "       Copia a mano lo que quieras de 'permissions.allow' y borra ese archivo."
} else {
  Copy-Item -Path $settingsOrigen -Destination $settingsDestino -Force
  Write-Host "  settings.json: instalado"
}

if ($Shopify) {
  if ($Global) {
    Write-Host ""
    Write-Host "  -Shopify no tiene sentido con -Global: el CLAUDE.md del tema es"
    Write-Host "  de proyecto. Ejecutalo sin -Global dentro del repo del tema."
  } else {
    $cmDestino = Join-Path $RaizProyecto 'CLAUDE.md'
    if (Test-Path $cmDestino) {
      Write-Host ""
      Write-Host "  Ya hay un CLAUDE.md en este proyecto, no lo he tocado."
      Write-Host "  La plantilla esta en $Origen\plantillas\CLAUDE.shopify.md"
    } else {
      Copy-Item -Path (Join-Path $Origen 'plantillas\CLAUDE.shopify.md') -Destination $cmDestino
      Write-Host "  CLAUDE.md del tema Shopify: copiado a $cmDestino"
    }
  }
}

Write-Host ""
Write-Host "Listo. Abre 'claude' y comprueba con /skills que estan las 34."
