# Get the current working directory
$wd = "C:\Users\ricar\OneDrive\Pictures\Desorganizadas"

# Get all files in subfolders
$files = Get-ChildItem -Path $wd -Recurse -File

# Create an array to store file info
$data = @()

foreach ($file in $files) {
    # Get the short name (file name without path)
    $fileName = $file.Name
    
    # Get the immediate subfolder name (relative to the working directory)
    $relativePath = $file.DirectoryName.Substring($wd.Path.Length).Trim('\')
    $subfolderName = ($relativePath -split '\\')[-1]  # Get the last part of the relative path
    
    # Add to data array
    $data += [PSCustomObject]@{
        FileName = $fileName
        Subfolder = $subfolderName
    }
}

# Export to CSV
$data | Export-Csv -Path "file_control\texts\folder_structure.csv" -NoTypeInformation -Encoding UTF8

Write-Output "CSV created at $wd\folder_structure.csv"
