. ".\file_control\utils.ps1"

function FindKebabCaseFolders {
    param (
        [string]$Paths,
        [string]$PathsRemove,
        [string]$OutputPath = "C:\Users\ricar\A-Note\kebab_case_folders.md"
    )

    # Finding folders and creating .md lines
    $folders = GetDirsChildren $Paths $PathsRemove -ReturnType "folders" | Where-Object {
        $_.Name -match '^[a-z0-9]+(-[a-z0-9]+)*$'
    } | ForEach-Object {
        "- [$($_.Name)]($($_.FullName))"
    }

    # Results
    $folders | Out-File -FilePath $OutputPath
    Write-Host "File created: $OutputPath"
}

# Application:
FindKebabCaseFolders $OneDrivePaths "$^" -OutputPath "$BaseOutput\folders_kebab.md"
