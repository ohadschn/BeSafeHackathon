$ErrorActionPreference = "Stop"
$PSNativeCommandUseErrorActionPreference = $true

Push-Location -LiteralPath "$PSScriptRoot/client"
try {
    npm install
    npm run build
}
finally {
    Pop-Location
}

Push-Location -LiteralPath "$PSScriptRoot/server"
try {
    npm install --omit=dev
}
finally {
    Pop-Location
}