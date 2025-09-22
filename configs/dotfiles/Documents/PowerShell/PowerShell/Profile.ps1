function prompt {
    $prefixes = @("C:\\Users\\ricar\\(A-[a-zA-Z]+)", "C:\\Users\\ricar\\OneDrive\\(A-[a-zA-Z]+)")
    $path = (Get-Location).Path
    $customPath = $path

    foreach ($prefix in $prefixes) {
        if ($path -match "$prefix") {
            $customPath = $path -replace $prefix, '$1'
            break
        }
    }

    "PS $customPath> "
}

[cultureinfo]::CurrentUICulture = 'en-US'


function addSiteAssets {
    param (
        [Parameter()][string]$destination = ".\site_assets"
    )

    $source = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\ricardo-semiao.github.io\site_assets"

    if (-not (Test-Path -Path $source)) {
        Write-Host "Source path does not exist: $source"
        return
    }

    if (Test-Path -Path $destination) {
        Write-Host "Destination path already exists: $destination"
        return
    }

    New-Item -ItemType Junction -Path $destination -Target $source
    Write-Host "Symbolic link created from 'ricardo-semiao.github.io' to $destination"
}

function createUrlFile {
    param (
        [string]$Url,
        [string]$OutputDirectory = "$env:USERPROFILE\Downloads"
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

function runasadm { param($cmd) runas /user:Administrator $cmd }

<#
function NewSymlink {
	param (
        [Parameter()][string]$Path,
        [Parameter()][string]$Target
    )
	
	New-Item -ItemType SymbolicLink -Path $Path -Target $Target
}

function NewSymlink2 {
	param (
		[Parameter()][string]$Start,
        [Parameter()][string]$Path,
        [Parameter()][string]$Target,
        [Parameter()][string]$End,
        [Parameter()][string]$Base = "C:\Users\ricar\OneDrive\A-Trabalho\Prog"
    )

	$Path = "$Base\$Start\$Path\$End"
	$Target = "$Base\$Start\$Target\$End"

    Write-Host "Creating symbolic link:"
    Write-Host "Path: $Path"
    Write-Host "Trgt: $Target"

	New-Item -ItemType SymbolicLink -Path $Path -Target $Target
}

function Move-Tex {
    param (
		[Parameter()][switch]$OwOk = $false,
        [Parameter()][string]$Source = '.\latex_build\text.pdf',
        [Parameter()][string]$Destination = '.'
    )

    if ((-not $OwOk) -and (Test-Path -Path $Destination)) {
        $userInput = Read-Host "A file with the same name already exists at the destination. Do you want to overwrite it? (Y/N)"
        if ($userInput -ne 'Y') {
            return
        }
    }
	
    Move-Item -Path $Source -Destination $Destination -Force
}
#>
