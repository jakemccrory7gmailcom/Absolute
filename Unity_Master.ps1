# Unity_Master.ps1
# The central script for managing all F:\UNITY operations.

Write-Host "Initializing F:\UNITY Master Script..." -ForegroundColor Green
$logFile = "F:\UNITY\Logs\UnityMasterLog.txt"

if (-not (Test-Path "F:\UNITY\Logs")) {
    New-Item -Path "F:\UNITY\Logs" -ItemType Directory -Force
}
Add-Content -Path $logFile -Value "$(Get-Date) - Unity_Master.ps1 initialized."

# --- 1. Startup Restoration ---
Write-Host "Running Startup Restoration tasks..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\StartupRestore.ps1" | Out-File -Append $logFile

# --- 2. Symbolic Link Repair ---
Write-Host "Repairing symbolic links..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\SymbolicLink_Repair.ps1" | Out-File -Append $logFile

# --- 3. GPU Load Balancing ---
Write-Host "Balancing GPU workloads..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumGPUOptimizer.ps1" | Out-File -Append $logFile

# --- 4. CPU Load Monitoring ---
Write-Host "Monitoring CPU load..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumCPULoadBalancer.ps1" | Out-File -Append $logFile

# --- 5. RAM Prefetch ---
Write-Host "Preloading assets into RAM..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumRAMPrefetch.ps1" | Out-File -Append $logFile

# --- 6. File Integrity Check ---
Write-Host "Verifying file integrity..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumIntegrityCheck.ps1" | Out-File -Append $logFile

# --- 7. File Monitoring ---
Write-Host "Starting file monitors..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumMonitor.ps1" | Out-File -Append $logFile

# --- 8. Backup ---
Write-Host "Running Backup..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumBackup.ps1" | Out-File -Append $logFile

# --- 9. Graphics Enhancements ---
Write-Host "Enhancing graphics settings..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\QuantumGraphicsEnhancer.ps1" | Out-File -Append $logFile

# --- 10. Game File Organization ---
Write-Host "Sorting game files..." -ForegroundColor Cyan
powershell.exe -File "F:\Scripts\Sort_Game_Files.ps1" | Out-File -Append $logFile

Write-Host "F:\UNITY Master Script completed successfully!" -ForegroundColor Green
Add-Content -Path $logFile -Value "$(Get-Date) - Unity_Master.ps1 completed successfully."