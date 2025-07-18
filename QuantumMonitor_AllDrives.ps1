# QuantumMonitor_AllDrives.ps1
# This script monitors the specified drives for file changes and triggers Update_Pool.ps1 accordingly.

$drivesToMonitor = @("C:\", "D:\", "E:\", "F:\", "G:\", "H:\", "I:\")

foreach ($drive in $drivesToMonitor) {
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $drive
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite, DirectoryName'
    $watcher.EnableRaisingEvents = $true

    Register-ObjectEvent $watcher "Changed" -Action {
        Write-Host "Change detected on $($Event.SourceEventArgs.FullPath) at drive $drive."
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null

    Register-ObjectEvent $watcher "Created" -Action {
        Write-Host "New file or folder created on $($Event.SourceEventArgs.FullPath) at drive $drive."
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null

    Register-ObjectEvent $watcher "Deleted" -Action {
        Write-Host "Deletion detected on $($Event.SourceEventArgs.FullPath) at drive $drive."
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null

    Register-ObjectEvent $watcher "Renamed" -Action {
        Write-Host "Rename detected: $($Event.SourceEventArgs.OldFullPath) to $($Event.SourceEventArgs.FullPath) at drive $drive."
        powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
    } | Out-Null
}

Write-Host "Quantum Monitor is running. Monitoring changes on drives: $($drivesToMonitor -join ', ')"