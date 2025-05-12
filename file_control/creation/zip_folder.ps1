function ZipFolder {
    param (
        [string]$Path,
        [bool]$ExcludeVideos = $true,
        [string]$OutputPath
    )

    # Filter and exclude file types (video and audio, large files)
    $excludeExtensions = @("*.mp4", "*.mod", "*.avi", "*.mov", "*.wmv", "*.flv", "*.mkv", "*.webm", "*.mpeg", "*.mpg", "*.m4v", "*.3gp", "*.3g2", "*.mp3", "*.wav", "*.aac", "*.flac", "*.ogg", "*.wma", "*.m4a", "*.aiff", "*.alac", "*.opus", "*.mkv")

    # Prepare a temporary directory to stage files before zipping
    $tempDir = Join-Path $env:TEMP "BackupTemp"
    if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
    New-Item -ItemType Directory -Path $tempDir | Out-Null

    # Copy files while optionally excluding specified extensions
    Get-ChildItem -Path $Path -Recurse -File | Where-Object {
        $exclude = $false
        if ($ExcludeVideos) {
            foreach ($ext in $excludeExtensions) {
                if ($_.Name -like $ext) { $exclude = $true; break }
            }
        }
        -not $exclude
    } | ForEach-Object {
        # Recreate folder structure in temp directory
        $relativePath = $_.FullName.Substring($Path.Length + 1)
        $destPath = Join-Path $tempDir $relativePath
        New-Item -ItemType Directory -Path (Split-Path $destPath) -Force | Out-Null
        Copy-Item -Path $_.FullName -Destination $destPath
    }

    # Compress the temporary directory into a ZIP file
    if (Test-Path $OutputPath) { Remove-Item $OutputPath -Force }
    Compress-Archive -Path "$tempDir\*" -DestinationPath $OutputPath

    # Clean up the temporary directory
    Remove-Item -Recurse -Force $tempDir
    Write-Host "File created: $OutputPath"
}

# Application:
$currentDate = Get-Date -Format "yyyy_MM_dd"
$Path = "C:\Users\ricar\OneDrive - Fundacao Getulio Vargas - FGV\A-GVCode"
$OutputPath = "$sourceDir\Áreas\Administrativo\Documentos permanentes\Sharepoint\Backups\GVCode_SP_$currentDate.zip"

ZipFolder $Path -OutputPath $OutputPath
