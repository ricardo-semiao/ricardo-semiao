$path = "C:\Users\ricar\OneDrive"
function IsKebabCase($str) {
    return $str -match '^[a-z0-9]+(-[a-z0-9]+)*$'
}

function FindKebabCaseFolders($path) {
    Get-ChildItem -Directory -Recurse $path | ForEach-Object {
        if (IsKebabCase($_.Name)) {
            $_.FullName
        }
    }
}

FindKebabCaseFolders -path $path

$mdFilePath = "C:\Users\ricar\A-Note\kebab_case_folders.md"
$folders = FindKebabCaseFolders -path $path

$folders | ForEach-Object {
    $folderName = $_.Name
    $fullPath = $_.FullName
    $mdLine = "- [$folderName]($fullPath)"
    $mdLine | Out-File -FilePath $mdFilePath -Append
}
