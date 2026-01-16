param(
    $ServerBuild = "$PSScriptRoot/server",
    $ClientBuild = "$PSScriptRoot/client/dist",
    [switch]$SkipPackageCleanupConfirmation
)

$ErrorActionPreference = 'Stop'

$buildFilesServer = Get-ChildItem -LiteralPath $ServerBuild -Recurse -Force
Write-Host "Server build files: $($buildFilesServer.FullName -join ', ')"

$buildFilesClient = Get-ChildItem -LiteralPath $ClientBuild -Recurse -Force
Write-Host "Client build files: $($buildFilesClient.FullName -join ', ')"

$pkgDir = "$PSScriptRoot/package"
$publicDir = "$pkgDir/public"
Write-Host "Preparing package folder at '$pkgDir'..."

if (Test-Path -LiteralPath $pkgDir) {
    Write-Host "Cleaning up existing package folder..."
    Remove-Item -LiteralPath $pkgDir -Recurse -Force -Confirm:(!$SkipPackageCleanupConfirmation) -Verbose
}

New-Item -ItemType Directory -Path $publicDir -Force -Verbose

Write-Host "Copying built files to package folder..."
Copy-Item -Path "$ServerBuild/*" -Destination $pkgDir -Recurse -Force -Verbose 
Copy-Item -Path "$ClientBuild/*" -Destination $publicDir -Recurse -Force -Verbose

Write-Host "Production bundle ready at '$pkgDir'"