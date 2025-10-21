. ".\file_control\utils.ps1"

function ZipFolder2 {
    param (
        [string[]]$Paths,
        [string]$OutputPath
    )

    $currentDate = Get-Date -Format "yyyy-MM-dd"
    $fileListPath = "$OutputPath\file_list.txt"
    $folderStructurePath = "$OutputPath\Folder structure"
    $backupPath = "$OutputPath\OneDrive_$currentDate.zip"

    # Filter and exclude file types (video and audio, large files)
    $excludeExtensions = @(
        "*.mp4", "*.mod", "*.avi", "*.mov", "*.wmv", "*.flv", "*.mkv", "*.webm",
        "*.mpeg", "*.mpg", "*.m4v", "*.3gp", "*.3g2", "*.mp3", "*.wav", "*.aac",
        "*.flac", "*.ogg", "*.wma", "*.m4a", "*.aiff", "*.alac", "*.opus", "*.mkv"
        ".recordings*.zip"
    )
    $excludeFolders = @(
        ".git", ".Rproj.user"
    )

    $fileList = GetDirsChildren $Paths | Where-Object {
        $exclude = $false
        foreach ($ext in $excludeExtensions) {
            if ($_.Name -like $ext) { $exclude = $true; break }
        }
        foreach ($folder in $excludeFolders) {
            if ($_.FullName -like "*\$folder\*") { $exclude = $true; break }
        }
        -not $exclude
    }
    
    $fileList | ForEach-Object {
        $_.FullName.Substring($OneDrivePath.Length + 1)
    } | Out-File -FilePath $fileListPath -Encoding UTF8
    Write-Host "Finished filtering files. Total files: $($fileList.Count)"

    $fileList | ForEach-Object {
        $relativePath = $_.FullName.Substring($OneDrivePath.Length + 1)
        $destPath = Join-Path $folderStructurePath $relativePath
        New-Item -ItemType Directory -Path (Split-Path $destPath) -Force | Out-Null
        New-Item -ItemType SymbolicLink -Path $destPath -Target $_.FullName | Out-Null
    }
    Write-Host "Finished recreating folder structure."

    Compress-Archive -Path "$folderStructurePath/*" -DestinationPath $backupPath
    Write-Host "File created: $backupPath."
}

# Application:2
$OutputPath = "E:\Backup onedrive ric"
ZipFolder2 $OneDrivePaths -OutputPath $OutputPath
