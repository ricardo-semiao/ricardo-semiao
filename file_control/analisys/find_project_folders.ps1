. ".\file_control\utils.ps1"

function FindProjectFolders {
    param (
        [string[]]$Paths,
        [string]$PathsRemove,
        [string]$OutputPath
    )

    # Coding projects-related files
    $exts = @(".Rproj", ".code-workspace")

    # Finding folders
    $folders = GetDirsChildren $Paths $PathsRemove  -ReturnType "folders"

    # Creating folder md lines
    $foldersLines = @()
    foreach ($folder in $folders) {
        $files = Get-ChildItem -Path $folder.FullName -File
        foreach ($file in $files) {
            if ($exts -contains $file.Extension) {
                $foldersLines += $folder
                break
            }
        }
    }

    # Results
    $foldersLines | ForEach-Object {
        "- [$($_.Name)]($($_.FullName))"
    } | Out-File -FilePath $OutputPath
    Write-Host "File created: $OutputPath"
}

# Application:
FindProjectFolders $OneDrivePaths "$^" -OutputPath "$BaseOutput\folders_projects.md"
