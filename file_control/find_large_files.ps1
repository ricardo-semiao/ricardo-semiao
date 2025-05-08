function prompt {
    $path = Get-Location
    $originalPrefix = "C:\Users\ricar\OneDrive\"
    $customPath = $path.Path

    if ($customPath -like "*$originalPrefix*") {
        $customPath = $customPath.Replace($originalPrefix, "")
    }

    "$customPath"
}

$sourceDirs = @("A-Estudo", "A-Trabalho", "A-Pessoal", "A-Outros") | ForEach-Object { "C:\Users\ricar\OneDrive\" + $_ }

$biggestFiles = @()

# Iterate through each source directory
foreach ($sourceDir in $sourceDirs) {
    $files = Get-ChildItem -Path $sourceDir -Recurse -File | Sort-Object -Property Length -Descending
    $biggestFiles += $files[0..19]
}

# Output the list of biggest files
$biggestFiles | Sort-Object -Property Length -Descending | Select-Object FullName, Length | ForEach-Object {
    Write-Host "$([math]::Round($_.Length / 1e+6, 1))mb - $(prompt($_.FullName))"
}
