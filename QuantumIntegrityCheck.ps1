# QuantumIntegrityCheck.ps1
$linkedFolders = @("F_Drive_Linked", "G_Drive_Linked", "H_Drive_Linked", "I_Drive_Linked")
$errors = @()

foreach ($folder in $linkedFolders) {
    $fullPath = "U:\Unity_Pool\$folder"
    if (!(Test-Path $fullPath)) {
        $errors += $folder
        Write-Host "ERROR: $fullPath is missing!" -ForegroundColor Red
    }
}

if ($errors.Count -eq 0) {
    Write-Host "Quantum Integrity Check PASSED. All links are healthy!" -ForegroundColor Green
} else {
    Write-Host "Integrity check FAILED for: $($errors -join ', ')" -ForegroundColor Red
    # Optionally trigger a fix procedure:
    powershell.exe -File "U:\UNITY_Pool\Scripts\Update_Pool.ps1"
}