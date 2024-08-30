function Count-Extensions {
    param (
        [Parameter(Mandatory=$true)]
        [string]$path
    )

    $files = Get-ChildItem -Path $path -File -Recurse
    $extensionCounts = @{}

    foreach ($file in $files) {
        $extension = $file.Extension.ToLower()

        if ($extension -ne "") {
            if ($extensionCounts.ContainsKey($extension)) {
                $extensionCounts[$extension]++
            } else {
                $extensionCounts[$extension] = 1
            }
        }
    }

    $extensionCounts
}
