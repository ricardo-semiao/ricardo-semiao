. ".\file_control\utils.ps1"

function FindBadSnakeCaseFolders {
    param (
        [string[]]$Paths,
        [string]$PathsRemove,
        [string]$OutputPath
    )

    # Finding folders
    $folders = GetDirsChildren $Paths $PathsRemove -ReturnType "folders"

    # Find bad snake case folders
    $foldersTable = $folders | ForEach-Object {
        $hasExtra = $_.Name -cmatch '^.+[A-Z]'

        # Ignore folders starting with a dot
        $hasInvisFolder = $false
        $folderParts = $_.FullName -split '\\'
        foreach ($part in $folderParts) {
            if ($part -cmatch '^\.') { $hasInvisFolder = $true }
        }

        # Ignore folders with prefixes or inside .Rcheck
        $hasPrefix = $_.Name -cmatch '^.+-[A-Z]'
        $hasRcheck = $_.Name -cmatch '\.Rcheck'

        if ($hasExtra -and (-not $hasPrefix) -and (-not $hasInvisFolder) -and (-not $hasRcheck)) {
            $_.FullName
        }
    }

    # Results
    $foldersTable | Out-File -FilePath $OutputPath
    Write-Host "File created: $OutputPath"
}

# Application:
FindBadSnakeCaseFolders $OneDrivePaths $NotionDir -OutputPath "$BaseOutput\folders_badsnake.txt"
