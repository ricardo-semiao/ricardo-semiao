function CreateRecursiveHardLink {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    # Recreating folder structure
    $createdDirs = @()
    Get-ChildItem -Path $sourcePath -Recurse -Directory | ForEach-Object {
        $newDir = $_.FullName.Replace($sourcePath, $destinationPath)
        New-Item -Path $newDir -ItemType Directory -Force
        $createdDirs += $newDir
    }

    # Adding hard links
    Get-ChildItem -Path $sourcePath -Recurse -File | ForEach-Object {
        $targetPath = $_.FullName
        $linkPath = $targetPath.Replace($sourcePath, $destinationPath)
        New-Item -ItemType HardLink -Path $linkPath -Target $targetPath
    }

    # Results
    Write-Host "Created hard links:"
    $createdDirs | ForEach-Object { Write-Host "-> $_" }
}
