# ggoled-script
Powershell scripts that work with [JerwuQu/ggoled](https://github.com/JerwuQu/ggoled) for [Steelseries Arctis Nova Pro GameDAC](https://steelseries.com/gaming-accessories/gamedac-gen-2)

These are scripts that allow you to view the time and the songs you are listening to on [Spotify](https://www.spotify.com/) or [Tidal](https://tidal.com/).

# How it works:
The script retrieves the title from Spotify and modifies it so that it shows the artist and the title of the song on different lines and if it is too long it cuts it to a maximum of 4 lines of 17 characters maximum per line (Maximum supported by the GameDAC).

# Requirements:
The text is shown to the GameDAC via the app created by [JerwuQu/ggoled](https://github.com/JerwuQu/ggoled) that you need to install following his guide.

# 

To run the script once downloaded, just right click and click on "Run with PowerShell"

Or follow this [guide](https://sentry.io/answers/run-a-powershell-script/)

The code is free to be used for other purposes and if you want to have a clean console just comment with "# " the part of the code relating to the display in the console.

Example :

"# Write-Host ..... "

# Script :

Time.ps1 = Show time every second

MediaMonitor.ps1 = Show time and if something is playing from supported apps it is shown to GameDAC
