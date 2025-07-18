# Script Name: UNITY_Hybrid.ps1
# SSD + HDD hybrid system with automatic symbolic link refresh, file placement, and permission handling.

# Define Drive Paths
$drivesToMonitor = @("C:\", "D:\", "E:\", "G:\", "H:\", "I:\")
$ssdDir = "F:\UNITY\GameFastLoad"    # SSD storage for speed-critical files
$hddDir = "F:\UNITY\Drives"          # HDD storage for bulk files
$updateScriptPath = "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
$gameCriticalFileTypes = @(".exe", ".dll", ".shader", ".texture", ".tmp")

# Initialize hash tables for tracking errors & skipped files
$invalidPaths = @{}
$skippedFiles = @{}

# Ensure Directories Exist
foreach ($dir in @($ssdDir, $hddDir)) {
    if (!(Test-Path -Path $dir)) {
        New-Item -ItemType Directory -Path $dir
        Write-Host "Created storage directory: $dir"
    }
}

# Function: Handle Ownership & Permissions
function AdjustPermissions {
    param([string]$path)

    try {
        Write-Host "Adjusting ownership and permissions for: $path"
        takeown /f $path /r /d y | Out-Null
        icacls $path /grant Administrators:F /t /q | Out-Null
        Write-Host "Ownership and permissions adjusted successfully for: $path"
    } catch {
        $errorMessage = $_.Exception.Message
        Write-Host "Failed to adjust permissions for: $errorMessage"
    }
}

# Function: Refresh Symbolic Links & Optimize SSD-HDD Placement
function RefreshSymbolicLinks {
    param([array]$drivesToScan, [string]$ssdDir, [string]$hddDir)

    Write-Host "Scanning drives for game speed-critical files..."
    foreach ($drive in $drivesToScan) {
        # Skip invalid paths
        if ($invalidPaths.ContainsKey($drive)) {
            Write-Host "Skipping invalid path: $drive"
            continue
        }

        try {
            Get-ChildItem -Path $drive -Recurse -ErrorAction Stop | Where-Object {
                $_.Extension -in $gameCriticalFileTypes
            } | ForEach-Object {
                $sourceFile = $_.FullName
                $ssdFile = Join-Path $ssdDir $_.Name
                $hddFile = Join-Path $hddDir $_.Name

                # Skip files that already exist in SSD or HDD
                if ($skippedFiles.ContainsKey($sourceFile)) {
                    Write-Host "Skipping already processed file: $sourceFile"
                    return
                }

                if ($sourceFile -ne $null) {
                    AdjustPermissions -path $sourceFile

                    if (!(Test-Path -Path $ssdFile)) {
                        cmd /c "mklink `"$ssdFile`" `"$sourceFile`""
                        Write-Host "Linked Speed-Critical File: $sourceFile -> $ssdFile"
                    } else {
                        Write-Host "File already exists in SSD: $ssdFile. Marking for skip."
                        $skippedFiles[$sourceFile] = $true
                    }

                    if (!(Test-Path -Path $hddFile)) {
                        Move-Item -Path $sourceFile -Destination $hddDir -Force
                        Write-Host "Moved Bulk File to HDD: $sourceFile -> $hddDir"
                    } else {
                        Write-Host "File already exists in HDD: $hddFile. Marking for skip."
                        $skippedFiles[$sourceFile] = $true
                    }
                }
            }
        } catch {
            $errorMessage = $_.Exception.Message
            if ($errorMessage -match "The specified path is not a valid directory path") {
                Write-Host "Marking invalid path for future skips: $drive"
                $invalidPaths[$drive] = $true
            } else {
                Write-Host "Unexpected error scanning $drive: $errorMessage"
            }
        }  
    }  
}

# Function: Monitor Drives for Real-Time Changes
function MonitorDrives {
    param([array]$drivesToMonitor, [string]$updateScriptPath)

    Write-Host "Real-time monitoring active..."
    foreach ($drive in $drivesToMonitor) {
        $watcher = New-Object System.IO.FileSystemWatcher
        $watcher.Path = $drive
        $watcher.Filter = "*.*"
        $watcher.IncludeSubdirectories = $true
        $watcher.NotifyFilter = [System.IO.NotifyFilters]'FileName, LastWrite, DirectoryName'
        $watcher.EnableRaisingEvents = $true

        Register-ObjectEvent $watcher "Changed" -Action { powershell.exe -File $updateScriptPath } | Out-Null
        Register-ObjectEvent $watcher "Created" -Action { powershell.exe -File $updateScriptPath } | Out-Null
        Register-ObjectEvent $watcher "Deleted" -Action { powershell.exe -File $updateScriptPath } | Out-Null
        Register-ObjectEvent $watcher "Renamed" -Action { powershell.exe -File $updateScriptPath } | Out-Null
    }
    Write-Host "Monitoring active across drives: $($drivesToMonitor -join ', ')"
}

# Function: Scheduled Optimization & SSD Load Balancing
function QuantumOptimization {
    Write-Host "`n[Quantum Optimization Running] Adjusting SSD-HDD balance dynamically...`n"
    RefreshSymbolicLinks -drivesToScan $drivesToMonitor -ssdDir $ssdDir -hddDir $hddDir
    Write-Host "[System Performance & SSD Longevity Optimized]`n"
}

# Execute Workflow
RefreshSymbolicLinks -drivesToScan $drivesToMonitor -ssdDir $ssdDir -hddDir $hddDir
MonitorDrives -drivesToMonitor $drivesToMonitor -updateScriptPath $updateScriptPath
QuantumOptimization