. ".\file_control\utils.ps1"

function FindFileLink {
    param (
        [string[]]$Paths,
        [string]$PathsRemove,
        [string]$StrRemove = "C:\Users\ricar\OneDrive\",
        [string]$OutputPath
    )

    # Links considered
    $linkTypes = @("SymbolicLink", "HardLink", "Junction")

    # Finding files
    $files = GetDirsChildren $Paths $PathsRemove | Where-Object { $linkTypes -contains $_.LinkType }
    $nIncorrect = 0

    # Creating the file table
    $filesTable = $files | ForEach-Object {
        $targetExists = Test-Path -Path $_.Target
        $nIncorrect += [int](-not $targetExists)

        [PSCustomObject]@{
            Functioning = $targetExists
            Path = $_.FullName.Replace($StrRemove, "")
            Target = $_.Target.Replace($StrRemove, "")
        }
    }

    # Results
    $filesTable | Export-Csv -Path $OutputPath -NoTypeInformation
    $len = $filesTable.Count
    Write-Host "$len file links found, $nIncorrect incorrect ones"
    Write-Host "File created: $OutputPath"
}

# Application:
FindFileLink $OneDrivePaths "$^" -OutputPath "$BaseOutput\files_links.csv"
