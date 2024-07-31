$sourceDir = "C:/Users/ricar"
$dotfilesRepo = "C:/Users/ricar/OneDrive/A-Trabalho/Prog/Personal/ricardo-semiao/configs/dotfiles"

$itemNames = @(
    ".gitconfig",
    ".gitignore",
    ".stata_kernel.conf",
    "Documents/WindowsPowerShell",
    "AppData/Roaming/Code/User/keybindings.json",
    "AppData/Roaming/Code/User/settings.json",
    "AppData/Roaming/RStudio/config.json",
    "AppData/Roaming/RStudio/rstudio-prefs.json"
)

foreach ($name in $itemNames) {
    $sourcePath = Join-Path -Path $sourceDir -ChildPath $name
    $destinationPath = Join-Path -Path $dotfilesRepo -ChildPath $name

    $destinationDir = Split-Path -Path $destinationPath -Parent
    if (-not (Test-Path -Path $destinationDir)) {
        New-Item -ItemType Directory -Path $destinationDir -Force
    }

    $item = Get-Item -Path $sourcePath -Force

    if ($item.PSIsContainer) {
        Copy-Item -Path $sourcePath -Destination $destinationPath -Recurse -Force
    } else {
        Copy-Item -Path $sourcePath -Destination $destinationPath -Force
    }

    #Remove-Item -Path $sourcePath -Recurse -Force

    #New-Item -ItemType SymbolicLink -Path $sourcePath -Target $destinationPath
}

Write-Output "Done."
