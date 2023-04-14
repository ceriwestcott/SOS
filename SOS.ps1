# DailyDashboard.ps1

# Define your script names and paths
$scripts = @{
    "Script1" = "C:\Scripts\Script1.ps1"
    "Script2" = "C:\Scripts\Script2.ps1"
    "Script3" = "C:\Scripts\Script3.ps1"
}

function ShowMenu {
    Write-Host "Script Dashboard"
    Write-Host "Today's script:"
    
    $index = 1
    $scripts.Keys | ForEach-Object {
        Write-Host "[$index] $_"
        $index++
    }
}

function GetScriptChoice {
    $dailyScriptIndex = (Get-Date).DayOfYear % $scripts.Count + 1
    $scriptKey = $scripts.Keys[$dailyScriptIndex - 1]
    $scripts[$scriptKey]
}

ShowMenu
$selectedScript = GetScriptChoice
Write-Host "Running $selectedScript..."
& $selectedScript
Write-Host "Script finished."
