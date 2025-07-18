# F_UNITY_All.ps1
# Unified script for managing all F:\UNITY operations.

param (
    [int]$gpuHighLoadThreshold = 85,  # High GPU load threshold
    [int]$gpuLowLoadThreshold = 30,   # Low GPU load threshold
    [int]$cpuHighLoadThreshold = 75,  # High CPU load threshold
    [string]$rtx4060 = "Gigabyte RTX 4060",  # Name of RTX 4060
    [string]$gtx980Ti = "EVGA GTX 980 Ti",   # Name of GTX 980 Ti
    [array]$drivesToMonitor = @("F:\", "G:\", "H:\", "I:\") # Drives for monitoring
)

Write-Host "Initializing F:\UNITY Unified Script..." -ForegroundColor Green
$logFile = "F:\UNITY\Logs\UnityUnifiedLog.txt"

# Ensure log directory exists
if (-not (Test-Path "F:\UNITY\Logs")) {
    New-Item -Path "F:\UNITY\Logs" -ItemType Directory -Force
}
Add-Content -Path $logFile -Value "$(Get-Date) - F_UNITY_All.ps1 initialized."

# --- 1. Startup Restoration ---
function StartupRestore {
    Write-Host "Running Startup Restoration tasks..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\StartupRestore.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error running StartupRestore.ps1: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error running StartupRestore.ps1: $_"
    }
}

# --- 2. Symbolic Link Repair ---
function RepairSymbolicLinks {
    Write-Host "Repairing symbolic links..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\SymbolicLink_Repair.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error repairing symbolic links: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error repairing symbolic links: $_"
    }
}

# --- 3. GPU Load Balancing ---
function HandleGPULoadBalancing {
    Write-Host "Balancing GPU workloads..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumGPUOptimizer.ps1" -highLoadThreshold $gpuHighLoadThreshold -lowLoadThreshold $gpuLowLoadThreshold | Out-File -Append $logFile
    } catch {
        Write-Host "Error in GPU load balancing: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error in GPU load balancing: $_"
    }
}

# --- 4. CPU Load Monitoring ---
function MonitorCPULoad {
    Write-Host "Monitoring CPU load..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumCPULoadBalancer.ps1" -threshold $cpuHighLoadThreshold | Out-File -Append $logFile
    } catch {
        Write-Host "Error monitoring CPU load: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error monitoring CPU load: $_"
    }
}

# --- 5. RAM Prefetch ---
function RAMPrefetch {
    Write-Host "Preloading assets into RAM..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumRAMPrefetch.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error in RAM prefetching: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error in RAM prefetching: $_"
    }
}

# --- 6. File Integrity Check ---
function CheckFileIntegrity {
    Write-Host "Verifying file integrity..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumIntegrityCheck.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error checking file integrity: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error checking file integrity: $_"
    }
}

# --- 7. File Monitoring ---
function MonitorFileChanges {
    Write-Host "Starting file monitors..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumMonitor_AllDrives.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error in file monitoring: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error in file monitoring: $_"
    }
}

# --- 8. Backup ---
function RunBackup {
    Write-Host "Running Backup..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumBackup.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error during backup: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error during backup: $_"
    }
}

# --- 9. Graphics Enhancements ---
function GraphicsEnhancer {
    Write-Host "Enhancing graphics settings..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\QuantumGraphicsEnhancer.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error enhancing graphics settings: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error enhancing graphics settings: $_"
    }
}

# --- 10. Game File Organization ---
function SortGameFiles {
    Write-Host "Sorting game files..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\Sort_Game_Files.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error sorting game files: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error sorting game files: $_"
    }
}

# --- 11. Update Path and Pool ---
function UpdatePathsAndPools {
    Write-Host "Updating file paths and pools..." -ForegroundColor Cyan
    try {
        powershell.exe -File "F:\Scripts\Update_Path.ps1" | Out-File -Append $logFile
        powershell.exe -File "F:\Scripts\Update_Pool.ps1" | Out-File -Append $logFile
    } catch {
        Write-Host "Error updating paths and pools: $_" -ForegroundColor Red
        Add-Content -Path $logFile -Value "$(Get-Date) - Error updating paths and pools: $_"
    }
}

# --- MAIN LOGIC ---
Write-Host "Executing F:\UNITY Unified Operations..." -ForegroundColor Green
StartupRestore
RepairSymbolicLinks
HandleGPULoadBalancing
MonitorCPULoad
RAMPrefetch
CheckFileIntegrity
MonitorFileChanges
RunBackup
GraphicsEnhancer
SortGameFiles
UpdatePathsAndPools

Write-Host "F:\UNITY Unified Script completed successfully!" -ForegroundColor Green
Add-Content -Path $logFile -Value "$(Get-Date) - F_UNITY_All.ps1 completed successfully."
