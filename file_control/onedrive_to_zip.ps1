# Define source directory and output ZIP path
$currentDate = Get-Date -Format "yyyy_MM_dd"
$sourceDirs = @("A-Estudo", "A-Trabalho", "A-Pessoal", "A-Outros") | ForEach-Object { "C:\Users\ricar\OneDrive\" + $_ }

# Prepare a temporary directory to stage files before zipping
$tempDir = Join-Path $env:TEMP "BackupTemp"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
New-Item -ItemType Directory -Path $tempDir | Out-Null

foreach ($sourceDir in $sourceDirs) {
    # Copy files while excluding specified extensions
    Get-ChildItem -Path $sourceDir -Recurse -File | ForEach-Object {
        # Recreate folder structure in temp directory
        $relativePath = $_.FullName.Substring($sourceDir.Length + 1)
        $destPath = Join-Path $tempDir $relativePath
        New-Item -ItemType Directory -Path (Split-Path $destPath) -Force | Out-Null
        Copy-Item -Path $_.FullName -Destination $destPath
    }
    
    Write-Output "folder $sourceDir done"
}

$backupZip = "D:\Backup onedrive ric\OneDrive_$currentDate.zip"

# Compress the temporary directory into a ZIP file
try {
    Compress-Archive -Path "$tempDir\*" -DestinationPath $backupZip -Force
    Write-Output "Backup completed: $backupZip"
} catch {
    Write-Error "Failed to create ZIP archive: $_"
}

# Clean up the temporary directory
Remove-Item -Recurse -Force $tempDir
