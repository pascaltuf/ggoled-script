function Get-MediaTitle {
    $process = Get-Process -Name "Tidal", "Spotify" -ErrorAction SilentlyContinue
    if ($process) {
        # Gets the title from the main window of the running process.
        $title = $process.MainWindowTitle
        
        # Converts the title to a string for length checking.
        $titleAsString = ($title -join "")
        # Write-Host "[DEBUG] Title Count (as string): " $titleAsString.Length

            # Checks if the Tidal or Spotify processes are running. If either is found, proceeds to retrieve the title.
            # If it finds the word "Tidal" or "Spotify" when a song is not playing, instead of showing the title, it shows the time
            if (($title -match "Tidal|Spotify") -or ($titleAsString.Length -eq 0)) {
                $currentTime = (Get-Date -Format "HH:mm:ss")
                $ggoledCommand = "ggoled text ""$currentTime"" -C -x c -y c -a c"
                Write-Host "Time (Process found):" $currentTime
                return $ggoledCommand
            } else {
                # Split the title into two parts using " - "
                $titleParts = $title -split ' - '

                # Finds the indices of the non-empty parts, handling leading spaces
                $part1Index = 0
                while (($part1Index -lt $titleParts.Count) -and ($titleParts[$part1Index] -eq "")) {
                    $part1Index++
                }

                $part2Index = $part1Index + 1
                while (($part2Index -lt $titleParts.Count) -and ($titleParts[$part2Index] -eq "")) {
                    $part2Index-- 
                    $part1Index-- 
                }

                $part1 = $titleParts[$part1Index]
                $part2 = if ($part2Index -ge 0) { $titleParts[$part2Index] } else { "" }  # Handles the case where $part2Index is negative

                # Truncates $part1 and $part2 to 17 characters if necessary, preserving shorter parts.
                $part1 = if ($part1.Length -gt 17) {
                    ($part1.Substring(0, 17) + "`n" + $part1.Substring(17, [math]::Min($part1.Length - 17, 17)))
                } else {
                    $part1
                }

                $part2 = if ($part2.Length -gt 17) {
                    ($part2.Substring(0, 17) + "`n" + $part2.Substring(17, [math]::Min($part2.Length - 17, 17)))
                } else {
                    $part2
                }

                Write-Host "Title : " $title
                # Write-Host "[DEBUG] Title divided into parts : " $titleParts
                # Write-Host "[DEBUG] Part 1 : " $part1
                # Write-Host "[DEBUG] Part 2 : " $part2

                # Constructs the GGOLED command with the truncated parts.
                $ggoledCommand = "ggoled text ""$part1 `n $part2"" -C -x c -y c -a c"
                # Write-Host "[DEBUG] Command created (Before): " $ggoledCommand

                return $ggoledCommand
            }
    } else {
        # If no Tidal or Spotify process is found, displays the current time
        $currentTime = (Get-Date -Format "HH:mm:ss")
        $ggoledCommand = "ggoled text ""$currentTime"" -C -x c -y c -a c"
        Write-Host "Time (No processes found):" $currentTime
        return $ggoledCommand
    }
}


# Continuously executes the code
while ($true) {
    # Calls Get-MediaTitle to get the GGOLED command.
    $ggoledCommand = Get-MediaTitle

    # Write-Host "[DEBUG] Command created (After): " $ggoledCommand

    # Executes the GGOLED command using Invoke-Expression.
    Invoke-Expression $ggoledCommand
    # Sleeps for 1 second to avoid excessive CPU usage.
    Start-Sleep -Seconds 1
}
