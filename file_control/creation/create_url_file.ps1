function CreateUrlFile {
    param (
        [string]$Url,
        [string]$OutputDirectory
    )

    # Ensure the output directory exists
    if (-not (Test-Path -Path $OutputDirectory)) {
        New-Item -ItemType Directory -Path $OutputDirectory
    }

    # Extract the filename using regex
    $pattern = "^.+/([A-Za-z\-]+)-[a-z0-9]{32}$"

    if ($Url -match $pattern) {
        $fileName = $matches[1] + ".url"
    } else {
        # If no match is found, use a default name
        $fileName = "default.url"
    }

    $outputPath = Join-Path -Path $OutputDirectory -ChildPath $fileName

    # Results
    Set-Content -Path $outputPath -Value "[InternetShortcut]`nURL=$Url"
    Write-Host "File created: $outputPath"
}

# Application:
$urls = @(
    "https://ricardo-semiao.notion.site/Mathematics-For-Economists-a8e88b9b141c46af8768bb55f8ba80c5",
    "https://ricardo-semiao.notion.site/Statistics-d832ee48a5d647a7b759fddf65bdf520",
    "https://ricardo-semiao.notion.site/Macroeconomics-I-de60f0d7d9814585b1ab85d301de666e",
    "https://ricardo-semiao.notion.site/Microeconomics-I-902b2f3e1c804df084e0c9d03eb396a5",
    "https://ricardo-semiao.notion.site/Econometrics-I-5424e03e90d74e53aad251e151604c25",
    "https://ricardo-semiao.notion.site/Macroeconomics-II-c46537ff9cb84204b9b5f4ef3f79ae18",
    "https://ricardo-semiao.notion.site/Microeconomics-II-4841167c80cb467baebc22eb3d5eea53",
    "https://ricardo-semiao.notion.site/Econometrics-II-c0245064ba1c47b687989527d166a66d"
)

foreach ($url in $urls) {
    CreateUrlFile -Url $url -OutputDirectory "C:\Users\ricar\A-Note\Temporarios"
}
