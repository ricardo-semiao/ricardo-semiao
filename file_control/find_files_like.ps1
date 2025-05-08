$files = Get-ChildItem -Path "C:\Users\ricar\OneDrive\" -Filter *.RData -Recurse | Sort-Object Length

function adjPath {
    param (
        [string]$path
    )
    return $path.Replace("\.RData", "")
}

foreach ($file in $files) {
    Write-Output "$($file.Length) - $(adjPath $file.FullName)"
}
