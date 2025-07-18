# Quantum Agent Script
# Monitors drives for changes and triggers updates for F:\UNITY

# Define drives to monitor
param (
    [array]$drivesToMonitor = @("F:\", "G:\", "H:\", "I:\")
)

# Define logging
$logFile = "F:\UNITY\Logs\QuantumAgentLog.txt"
if (-not (Test-Path "F:\UNITY\Logs")) {
    New-Item -Path "F:\UNITY\Logs" -ItemType Directory -Force
}

Write-Host "Starting Quantum Agent monitoring for drives: $($drivesToMonitor -join ', ')" -ForegroundColor Green

foreach ($drive in $drivesToMonitor) {
    Start-Job -ScriptBlock {
        param($d)
        $watcher = New-Object System.IO.FileSystemWatcher $d, "*.*"
        $watcher.IncludeSubdirectories = $true
        $watcher.EnableRaisingEvents = $true

        # Register event for any change
        Register-ObjectEvent $watcher "Changed" -Action {
            Write-Output "Change detected on $($Event.SourceEventArgs.FullPath) at drive $d." | Tee-Object -FilePath $logFile
            Add-Content -Path $logFile -Value "$(Get-Date) - Triggering pool update for F:\UNITY."
            
            # Retry mechanism for pool update
            $retryCount = 3
            while ($retryCount -gt 0) {
                try {
                    powershell.exe -File "F:\UNITY\Scripts\Update_Pool.ps1"
                    Write-Host "Pool update succeeded for F:\UNITY." -ForegroundColor Green
                    Add-Content -Path $logFile -Value "$(Get-Date) - Pool update succeeded for F:\UNITY."
                    break
                } catch {
                    Write-Host "Pool update failed for F:\UNITY. Retrying..." -ForegroundColor Red
                    $retryCount--
                    Add-Content -Path $logFile -Value "$(Get-Date) - Pool update failed for F:\UNITY. Retry remaining: $retryCount."
                }
            }
        } | Out-Null

        while ($true) { Start-Sleep -Seconds 10 }
    } -ArgumentList $drive
}

Write-Host "Quantum Agent jobs launched for drives: $($drivesToMonitor -join ', ')" -ForegroundColor Cyan
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show("Quantum Agent monitoring started for drives: $($drivesToMonitor -join ', ')", "Notification")