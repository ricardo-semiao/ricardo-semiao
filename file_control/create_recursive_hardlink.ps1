function Create-RecursiveHardLink {
    param (
        [string]$sourcePath,
        [string]$destinationPath
    )

    $createdDirs = @()
    Get-ChildItem -Path $sourcePath -Recurse -Directory | ForEach-Object {
        $newDir = $_.FullName -replace [regex]::Escape($sourcePath), $destinationPath
        New-Item -Path $newDir -ItemType Directory -Force
        $createdDirs += $newDir
    }
    Get-ChildItem -Path $sourcePath -Recurse -File | ForEach-Object {
        $targetPath = $_.FullName
        $linkPath = $targetPath -replace [regex]::Escape($sourcePath), $destinationPath
        New-Item -ItemType HardLink -Path $linkPath -Target $targetPath
    }

    Write-Host "Created hard links:"
    $createdDirs | ForEach-Object { Write-Host "-> $_" }
}
