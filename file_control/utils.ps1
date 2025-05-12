# Functions:
function GetDirsChildren {
    param(
        [string[]]$Paths,
        [string]$PathsRemove = "$^",
        [string]$PathsKeep = "*",
        [int]$NumberOfFiles = 0,
        [string]$ReturnType = "files"
    )

    $children = [System.Collections.Generic.List[Object]]::new()

    foreach ($dir in $Paths) {
        $children += if ($ReturnType -eq "files") {
            if ($PathsKeep -eq "*") {
                Get-ChildItem -Path $dir -Recurse -File 
            } else {
                Get-ChildItem -Path $dir -Recurse -File -Filter $PathsKeep
            }
        } else {
            if ($PathsKeep -eq "*") {
                Get-ChildItem -Path $dir -Recurse -Directory
            } else {
                Get-ChildItem -Path $dir -Recurse -Directory -Filter $PathsKeep
            }
        }
    }

    if ($PathsRemove -ne "$^") {
        $children = $children | Where-Object { $_.FullName -notlike $PathsRemove }
    }

    if ($NumberOfFiles -gt 0) {
        $children = $children | Sort-Object Length -Descending | Select-Object -First $NumberOfFiles
    }
    
    if ($children -isnot [array]) {
        $children = @($children; $children)
    }
    
    return $children
}


# Values:
$OneDrivePaths = @(
    "C:\Users\ricar\OneDrive\A-Outros",
    "C:\Users\ricar\OneDrive\A-Estudo",
    "C:\Users\ricar\OneDrive\A-Trabalho",
    "C:\Users\ricar\OneDrive\A-Pessoal"
)
$OneDrivePaths = "C:\Users\ricar\OneDrive\A-Trabalho"

$NotionPath = "C:\Users\ricar\OneDrive\A-Outros\misc-notion-backup\workspace*"

$BaseOutput = ".\file_control\output"
