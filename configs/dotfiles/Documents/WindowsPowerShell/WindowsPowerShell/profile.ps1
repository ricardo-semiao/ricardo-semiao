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

function prompt {
    $path = Get-Location
    $originalPrefix = "C:\Users\ricar\"
    $customPath = $path.Path

    if ($customPath -like "*$originalPrefix*") {
        $customPath = $customPath.Replace($originalPrefix, "")
    }

    "PS $customPath> "
}
