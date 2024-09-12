# FSLogix Installation Script

# Create temporary folder
$downloadPath = "C:\Temp\FSLogix"
$zipPath = "$downloadPath\FSLogix.zip"
$extractPath = "$downloadPath\Extracted"
$installerPath = "$extractPath\x64\Release\FSLogixAppsSetup.exe"

# Create folder if it doesn't exist
if (-Not (Test-Path -Path $downloadPath)) {
    New-Item -ItemType Directory -Path $downloadPath
}

# Download FSLogix zip file
$fslogixDownloadUrl = "https://aka.ms/fslogix_download"
Invoke-WebRequest -Uri $fslogixDownloadUrl -OutFile $zipPath

# Extract the zip file
Expand-Archive -Path $zipPath -DestinationPath $extractPath

# Run FSLogix installer
if (Test-Path $installerPath) {
    Start-Process -FilePath $installerPath -ArgumentList "/install /quiet" -Wait
} else {
    Write-Error "FSLogix installer not found. Path: $installerPath"
}

# Delete temporary files (optional)
Remove-Item -Path $downloadPath -Recurse -Force
