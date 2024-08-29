function Get-Time {
        $currentTime = (Get-Date -Format "HH:mm:ss")
        $ggoledCommand = "ggoled text ""$currentTime"" -C -x c -y c -a c"
        # Write-Host "[DEBUG] Command created (Before): " $ggoledCommand
        Write-Host "Time : " $currentTime
        return $ggoledCommand
    }

# Continuously executes the code
while ($true) {
    # Calls Get-MediaTitle to get the GGOLED command.
    $ggoledCommand = Get-Time

    # Write-Host "[DEBUG] Command created (After): " $ggoledCommand "`n"

    # Executes the GGOLED command using Invoke-Expression.
    Invoke-Expression $ggoledCommand
    # Sleeps for 1 second to avoid excessive CPU usage.
    Start-Sleep -Seconds 1
}
