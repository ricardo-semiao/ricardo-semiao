$directories = @(
    "C:\Users\ricar\OneDrive\A-Outros",
    "C:\Users\ricar\OneDrive\A-Estudo",
    "C:\Users\ricar\OneDrive\A-Trabalho",
    "C:\Users\ricar\OneDrive\A-Pessoal"
)
$excludePath = "C:\Users\ricar\OneDrive\A-Outros\misc-notion-backup\workspace*"

function Get-ChildSpecific($dir) {
    Get-ChildItem -Path $dir -Recurse -Directory | Where-Object { $_.FullName -notlike $excludePath }
}

$items = @()
foreach ($dir in $directories) {
    $items += Get-ChildItem -Path $dir -Recurse
}

$symlinks = $items | Where-Object { $_.LinkType -eq "SymbolicLink" -or $_.LinkType -eq "HardLink" }

$results = @("Functioning, Path, Target")
$incorrects = 0
foreach ($sym in $symlinks) {
    $targetExists = Test-Path -Path $sym.Target
    $incorrects += -not $targetExists

    $fullName = $sym.FullName -replace [regex]::Escape("C:\Users\ricar\OneDrive\"), ""
    $target = $sym.Target -replace [regex]::Escape("C:\Users\ricar\OneDrive\"), ""

    $results += "$targetExists, $fullName, $target"
}

$results | Out-File -FilePath "texts/symlinks.csv"

$len = $results.Length-1
Write-Output "$len symlinks found, $incorrects incorrect ones. Result in 'texts/symlinks.csv'."
