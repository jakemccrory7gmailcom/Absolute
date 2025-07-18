# QuantumMonitor.ps1
# This script monitors a set of drives for any file changes and then re-runs Update_Pool.ps1.

# Define the drives to monitor (you can add more if needed)
$drivesToMonitor = @("F:\", "G:\", "H:\", "I:\")

foreach ($drive in $drivesToMonitor) {
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $drive
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite, DirectoryName'
    $watcher.EnableRaisingEvents = $true

    Register-ObjectEvent $watcher "Changed" -Action {
        Write-Host "Change detected on $($Event.SourceEventArgs.FullPath)`n Updating the pool..."
        # Trigger the pool update script - adjust the path if needed.
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null

    # You can also register events for Created, Deleted, and Renamed if desired
    Register-ObjectEvent $watcher "Created" -Action {
        Write-Host "New file detected on $($Event.SourceEventArgs.FullPath)`n Updating the pool..."
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null
}

Write-Host "Quantum Monitor is running. Monitoring changes on drives F:\, G:\, H:\, and I:\"