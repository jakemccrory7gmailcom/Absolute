# QuantumGraphicsEnhancer.ps1
# Retrieves GPU details and pre-caches high-res textures for improved graphics performance.

try {
    # Retrieve GPU information using WMI
    $gpuInfo = Get-WmiObject -Namespace root\CIMV2 -Class Win32_VideoController | Select-Object Name, AdapterRAM
    Write-Host "GPU Information:" -ForegroundColor Cyan
    $gpuInfo | Format-Table -AutoSize
} catch {
    Write-Host "Error retrieving GPU information." -ForegroundColor Red
}

# Define the source folder for high-resolution textures (adjust as needed)
$sourceGraphicsFolder = "F:\GameAssets\HighResTextures"
# Define the destination folder on the physical HDD where assets will be cached
$destinationCache = "I:\CacheFiles\GraphicsCache\HighResTextures"

# Ensure the destination exists
if (!(Test-Path $destinationCache)) {
    New-Item -Path $destinationCache -ItemType Directory -Force
    Write-Host "Created cache directory at $destinationCache" -ForegroundColor Green
}

Write-Host "Pre-caching graphics assets from $sourceGraphicsFolder to $destinationCache..." -ForegroundColor Green
# Use robocopy to mirror assets from the source to the cache
robocopy $sourceGraphicsFolder $destinationCache /MIR /R:1 /W:1

Write-Host "Graphics assets pre-cache complete." -ForegroundColor Green