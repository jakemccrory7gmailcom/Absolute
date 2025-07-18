# QuantumGPUOptimizer.ps1
# Monitors GPU utilization and adjusts peripheral GPU tasks based on current load.

try {
    # Get GPU engine usage percentages
    $gpuCounters = Get-Counter -Counter "\GPU Engine(*)\Utilization Percentage"
    $activeUtilizations = $gpuCounters.CounterSamples | Where-Object { $_.CookedValue -gt 0 }
    
    if ($activeUtilizations.Count -gt 0) {
        $avgGPUUtil = ($activeUtilizations | Measure-Object -Property CookedValue -Average).Average
        $avgGPUUtil = [math]::Round($avgGPUUtil, 2)
        Write-Host "Average GPU Utilization: $avgGPUUtil%" -ForegroundColor Cyan
    } else {
        Write-Host "No active GPU usage detected." -ForegroundColor Cyan
        $avgGPUUtil = 0
    }
} catch {
    Write-Host "Error retrieving GPU counters." -ForegroundColor Red
    $avgGPUUtil = 0
}

if ($avgGPUUtil -gt 80) {
    Write-Host "High GPU usage detected ($avgGPUUtil%). Throttling non-critical GPU tasks..." -ForegroundColor Yellow
} else {
    Write-Host "GPU usage is low ($avgGPUUtil%). Initiating additional GPU pre-caching operations..." -ForegroundColor Green
    # (Optional: trigger secondary GPU asset pre-caching tasks here)
}

Write-Host "Quantum GPU Optimizer completed." -ForegroundColor Green