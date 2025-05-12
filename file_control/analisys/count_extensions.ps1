. ".\file_control\utils.ps1"

function CountFileExtensions {
    param (
        [string]$Path,
        [string]$PathsRemove,
        [string]$OutputPath
    )

    # Get files
    $files = GetDirsChildren $Paths $PathsRemove
    $extensionCounts = @{}

    # Count extensions
    foreach ($file in $files) {
        $extension = $file.Extension.ToLower()

        if ($extension -ne "") {
            if ($extensionCounts.ContainsKey($extension)) {
                $extensionCounts[$extension]++
            } else {
                $extensionCounts[$extension] = 1
            }
        }
    }

    # Results
    $extensionCounts.GetEnumerator() | Sort-Object Name | ForEach-Object {
        [PSCustomObject]@{
            Extension = $_.Key
            Count = $_.Value
        }
    } | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8

    Write-Host "File created: $OutputPath"
}

# Application:
CountFileExtensions $OneDrivePaths "$^" -OutputPath "$BaseOutput\extensions.csv"
