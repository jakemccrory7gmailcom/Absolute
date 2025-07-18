# Script Name: ScanUnityStructureAndLinkGameFiles.ps1
# Purpose: Scans mirrored drives and physical F: for speed-critical game files and refreshes symbolic links.

function ScanUnityStructureAndLinkGameFiles {
    param(
        [string]$DrivesDir,      # Directory to scan symbolic mirrored drives (e.g., F:\UNITY\Drives)
        [string]$PhysicalFDir,   # Physical F: drive to scan directly
        [string]$LinkDir         # Directory where symbolic links will be created
    )

    # File Types to Identify (Executables, Textures, Shaders, etc.)
    $GameCriticalFileTypes = @(".exe", ".dll", ".shader", ".texture", ".tmp")

    # Create Link Directory if It Doesn't Exist
    if (!(Test-Path -Path $LinkDir)) {
        New-Item -ItemType Directory -Path $LinkDir
    }

    # Scan F:\UNITY\Drives for Critical Files
    Write-Host "Scanning Mirrored Directory: $DrivesDir..."
    Get-ChildItem -Path "$DrivesDir\" -Recurse -ErrorAction SilentlyContinue | Where-Object {
        $_.Extension -in $GameCriticalFileTypes
    } | ForEach-Object {
        $SourceFile = $_.FullName
        $LinkFile = Join-Path $LinkDir $_.Name

        if ($SourceFile -ne $null) {
            # Remove Existing Symbolic Link if It Exists
            if (Test-Path -Path $LinkFile) {
                Remove-Item -Path $LinkFile -Force
                Write-Host "Removed existing symbolic link: $LinkFile"
            }

            # Create New Symbolic Link
            cmd /c "mklink `"$LinkFile`" `"$SourceFile`""
            Write-Host "Linked: $SourceFile -> $LinkFile"
        } else {
            Write-Host "Skipping null entry: $SourceFile"
        }
    }

    # Scan Physical F: Drive for Critical Files
    Write-Host "Scanning Physical F: Drive: $PhysicalFDir..."
    Get-ChildItem -Path "$PhysicalFDir\" -Recurse -ErrorAction SilentlyContinue | Where-Object {
        $_.Extension -in $GameCriticalFileTypes
    } | ForEach-Object {
        $SourceFile = $_.FullName
        $LinkFile = Join-Path $LinkDir $_.Name

        if ($SourceFile -ne $null) {
            # Remove Existing Symbolic Link if It Exists
            if (Test-Path -Path $LinkFile) {
                Remove-Item -Path $LinkFile -Force
                Write-Host "Removed existing symbolic link: $LinkFile"
            }

            # Create New Symbolic Link
            cmd /c "mklink `"$LinkFile`" `"$SourceFile`""
            Write-Host "Linked: $SourceFile -> $LinkFile"
        } else {
            Write-Host "Skipping null entry: $SourceFile"
        }
    }

    Write-Host "Symbolic Links for Game Speed-Critical Files Refreshed Successfully!"
}

# Example Usage
ScanUnityStructureAndLinkGameFiles -DrivesDir "F:\UNITY\Drives" -PhysicalFDir "F:" -LinkDir "F:\UNITY\GameFastLoad"
