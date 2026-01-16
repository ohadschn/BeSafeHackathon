param(
    $BuildFolder = $PSScriptRoot,
    [switch]$SkipPackageCleanupConfirmation
)

$ErrorActionPreference = 'Stop'

Write-Host "Packaging build files from '$BuildFolder'..."
$buildFiles = Get-ChildItem -LiteralPath $BuildFolder -Recurse -Force
Write-Host "Build files: $($buildFiles.FullName -join ', ')"

$pkgDir = "$PSScriptRoot/package"
Write-Host "Preparing package folder at '$pkgDir'..."

if (Test-Path -LiteralPath $pkgDir) {
    Write-Host "Cleaning up existing package folder..."
    Remove-Item -LiteralPath $pkgDir -Recurse -Force -Confirm:(!$SkipPackageCleanupConfirmation)
}

New-Item -ItemType Directory -Path $pkgDir -Verbose

Write-Host "Copying built files to package folder..."
Copy-Item -Recurse -Force "$BuildFolder/client" $pkgDir
Copy-Item -Recurse -Force "$BuildFolder/server" $pkgDir

Write-Host "Production bundle ready at '$pkgDir'"