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
function TestPath($item) {
    $hasExtra = $item.Name -cmatch '^.+[A-Z]'

    $hasPrefix = $item.Name -cmatch '^.+-[A-Z]'
    $hasRcheck = $item.Name -cmatch '\.Rcheck'
    #$hasI = $item.Name -cmatch ' I+$' #-and (-not $hasI) 

    $hasInvisfolder = $false
    $itemParts = $item.FullName -split '\\'
    foreach ($part in $itemParts) {
        if ($part -cmatch '^\.') {$hasInvisfolder = $true}
    }

    return $hasExtra -and (-not $hasPrefix) -and (-not $hasInvisfolder) -and (-not $hasRcheck)
}

$folders = @()
foreach ($dir in $directories) {
    $folders += Get-ChildSpecific $dir
}
$foldersExtraUppercase = @()
foreach ($item in $folders) {
    if (TestPath $item) {
        $foldersExtraUppercase += $item.FullName
    }
}

$filePath = "texts/extra_uppercase_folders.txt"
$foldersExtraUppercase | Out-File -FilePath $filePath

Write-Output "File created: $filePath"
