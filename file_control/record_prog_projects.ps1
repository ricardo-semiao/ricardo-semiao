$exts = @(".Rproj", ".code-workspace")

function CheckSubdirs($path) {
    $recordedSubdirs = @()
    $subdirs = Get-ChildItem -Path $path -Directory -Recurse

    foreach ($subdir in $subdirs) {
        $files = Get-ChildItem -Path $subdir.FullName -File
        foreach ($file in $files) {
            if ($exts -contains $file.Extension) {
                $recordedSubdirs += $subdir
            }
        }
    }

    return $recordedSubdirs
}

$directories = @(
    "C:\Users\ricar\OneDrive\A-Outros",
    "C:\Users\ricar\OneDrive\A-Estudo",
    "C:\Users\ricar\OneDrive\A-Trabalho",
    "C:\Users\ricar\OneDrive\A-Pessoal"
)

$folders = @()
foreach ($dir in $directories) {
    $folders += CheckSubdirs $dir
}

$mdFilePath = "texts/kebab_case_folders.md"
$folders | ForEach-Object {
    $folderName = $_.Name
    $fullPath = $_.FullName
    $mdLine = "- [$folderName]($fullPath)"
    $mdLine | Out-File -FilePath $mdFilePath -Append
}
