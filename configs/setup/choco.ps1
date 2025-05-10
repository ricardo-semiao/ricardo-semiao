
# First - install basic software by hand:
# chrome, norton, phone link, riot client, whatsapp, teams, chocolatey


# Second - install via chocolatey:
$packages = @(
	"git", "sqlite", "sqlitebrowser", "quarto", #programming utility software
	"vscode", "notepadplusplus", "r.studio", #programming envs
	"r", "python", "golang", "sass", "octave", "julia", "openjdk", "miktex", "strawberryperl" #programming languages
	"spotify", "steam", "epicgameslauncher", "discord", "ubisoft-connect",  #entretainment
	"notion", "powertoys", "czkawka", "7zip", "file-converter", "linkshellextension", #tools
	"audacity", "gimp", "musescore", "reaper", "lightworks" #creativity
)

Set-ExecutionPolicy AllSigned

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

foreach ($package in $packages) {
    choco install $package --yes
}


# Third - install large software:
# rtools, nvidia app (https://www.nvidia.com/pt-br/software/nvidia-app/)
# others not supported (as of 01/2025): "toggl", "ea-app"
#
# choco install cuda
#
# pip3 install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu126
# pip install surya-ocr
# pip install streamlit pdftext
