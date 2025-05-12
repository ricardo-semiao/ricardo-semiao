function SaveFolderStructure {
    param (
        [string]$Path,
        [string]$OutputPath
    )

    # Find files
    $files = Get-ChildItem -Path $Path -Recurse -File

    # Creating file table
    $filesTable = $files | ForEach-Object {
        # Get the immediate subfolder name (relative to the working directory)
        $relativePath = $_.DirectoryName.Substring($Path.Length).Trim('\')

        [PSCustomObject]@{
            FileName = $_.Name
            Subfolder = ($relativePath -split '\\')[-1] # Get the last part of the relative path
        }
    }

    # Results
    $filesTable | Export-Csv -Path $OutputPath -NoTypeInformation -Encoding UTF8
    Write-Output "File created: $OutputPath"
}

# Application:
SaveFolderStructure "C:\Users\ricar\OneDrive\Pictures\Desorganizadas" -OutputPath "$BaseOutput\folder_structure.md"
