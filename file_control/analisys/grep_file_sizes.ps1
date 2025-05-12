. ".\file_control\utils.ps1"

function GrepFilesize {
    param (
        [string[]]$Paths,
        [string]$PathsRemove,
        [string]$PathsKeep,
        [int]$NumberOfFiles = 0,
        [string]$StrRemove = "C:\Users\ricar\OneDrive\",
        [bool]$SortBySize = $true,
        [string]$OutputPath
    )

    # Removing also $PathsKeep (without the wildcard)
    [regex]$StrRemove = "($([regex]::Escape($StrRemove)))|($([regex]::Escape($PathsKeep.Trim('*'))))"

    # Finding files
    $files = GetDirsChildren $Paths $PathsRemove $PathsKeep -NumberOfFiles $NumberOfFiles

    # Creating the file table
    $filesTable = $files | ForEach-Object {
        [PSCustomObject]@{
            Name = [regex]::Replace($_.FullName, $StrRemove, "")
            Size = "{0:N2} MB" -f ($_.Length / 1MB)
        }
    }

    # Sorting the file table
    if ($SortBySize) {
        $filesTable = $filesTable | Sort-Object -Property @{
            Expression = {[double]($_.Size -replace ",| MB", "")}
        } -Descending
    }

    # Results
    $filesTable | Export-Csv -Path $OutputPath -NoTypeInformation
    Write-Host "File created: $OutputPath"
}

# Application:
GrepFilesize $OneDrivePaths $NotionPath "*.RData" -OutputPath "$BaseOutput\files_rdata.csv"
GrepFilesize $OneDrivePaths $NotionPath "*" 40 -OutputPath "$BaseOutput\files_large.csv"
