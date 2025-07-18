# Set new cache location with ample space
$cacheLocation = "I:\CacheFiles"
if (!(Test-Path -LiteralPath $cacheLocation)) {
    New-Item -Path $cacheLocation -ItemType Directory -Force
    Write-Host "Created cache directory: $cacheLocation" -ForegroundColor Green
}