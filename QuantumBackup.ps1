# QuantumBackup.ps1
# Backs up data from the source to the destination using Robocopy, with proper log file handling.

param (
    [string]$source = "U:\",  # Source directory (RAM disk)
    [string]$destination = "F:\Unity_Backup\"  # Backup destination
)

# Define log file
$logFile = "F:\Unity_Backup\QuantumBackupLog.txt"

# Verify or create destination path
if (!(Test-Path -LiteralPath $destination)) {
    New-Item -Path $destination -ItemType Directory -Force
    Write-Host "Created destination directory: $destination" -ForegroundColor Green
}

# Ensure the log file exists
if (!(Test-Path -LiteralPath $logFile)) {
    New-Item -Path $logFile -ItemType File -Force
    Write-Host "Created log file: $logFile" -ForegroundColor Green
}
Add-Content -Path $logFile -Value "$(Get-Date) - Starting Quantum Backup."

# Verify source path
if (!(Test-Path -LiteralPath $source)) {
    Write-Host "Error: Source path $source does not exist." -ForegroundColor Red
    Add-Content -Path $logFile -Value "$(Get-Date) - Error: Source path $source does not exist."
    exit
}

# Mirror source to destination using Robocopy with exclusions
$robocopyCommand = "robocopy.exe `"$source`" `"$destination`" /MIR /R:2 /W:2 /LOG+:`"$logFile`" /XF *.gpu_resources *.tmp *.log"
Write-Host "Executing Robocopy: $robocopyCommand" -ForegroundColor Yellow

$robocopyResult = Invoke-Expression $robocopyCommand
if ($LASTEXITCODE -eq 0) {
    Write-Host "Robocopy completed successfully!" -ForegroundColor Green
    Add-Content -Path $logFile -Value "$(Get-Date) - Robocopy completed successfully."
} elseif ($LASTEXITCODE -eq 1) {
    Write-Host "Robocopy completed with minor issues (e.g., skipped files)." -ForegroundColor Yellow
    Add-Content -Path $logFile -Value "$(Get-Date) - Robocopy completed with minor issues."
} else {
    Write-Host "Robocopy encountered errors. Exit code: $LASTEXITCODE" -ForegroundColor Red
    Add-Content -Path $logFile -Value "$(Get-Date) - Robocopy failed with exit code $LASTEXITCODE."
}

Write-Host "Quantum Backup complete: $source mirrored to $destination" -ForegroundColor Green
Add-Content -Path $logFile -Value "$(Get-Date) - Quantum Backup complete."

# Notification
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show("Quantum Backup Complete!", "Notification")