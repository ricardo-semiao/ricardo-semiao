# Em "https://gvmail.sharepoint.com/sites/GVCode/Documentos%20Compartilhados/Forms/AllItems.aspx",
#Selecione "adicionar atalho no OneDrive", adicionando um atalho do SharePoint da Code no seu OneDrive da FGV
# Conecte seu OneDrive da FGV em seu computador, ele estará disponível como uma pasta em seu computador agora
# Coloque o caminho do atalho do SharePoint da Code no seu PC/OneDrive na variável `$sourceDir`
# Rode o código

# Define source directory and output ZIP path
$currentDate = Get-Date -Format "yyyy_MM_dd"
$sourceDir = "C:\Users\ricar\OneDrive - Fundacao Getulio Vargas - FGV\A-GVCode"
$backupZip = "$sourceDir\Áreas\Administrativo\Documentos permanentes\Sharepoint\Backups\GVCode_SP_$currentDate.zip"

# Filter and exclude file types (video and audio, large files)
$excludeExtensions = @("*.mp4", "*.mod", "*.avi", "*.mov", "*.wmv", "*.flv", "*.mkv", "*.webm", "*.mpeg", "*.mpg", "*.m4v", "*.3gp", "*.3g2", "*.mp3", "*.wav", "*.aac", "*.flac", "*.ogg", "*.wma", "*.m4a", "*.aiff", "*.alac", "*.opus", "*.mkv")

# Prepare a temporary directory to stage files before zipping
$tempDir = Join-Path $env:TEMP "BackupTemp"
if (Test-Path $tempDir) { Remove-Item -Recurse -Force $tempDir }
New-Item -ItemType Directory -Path $tempDir | Out-Null

# Copy files while excluding specified extensions
Get-ChildItem -Path $sourceDir -Recurse -File | Where-Object {
    $exclude = $false
    foreach ($ext in $excludeExtensions) {
        if ($_.Name -like $ext) { $exclude = $true; break }
    }
    -not $exclude
} | ForEach-Object {
    # Recreate folder structure in temp directory
    $relativePath = $_.FullName.Substring($sourceDir.Length + 1)
    $destPath = Join-Path $tempDir $relativePath
    New-Item -ItemType Directory -Path (Split-Path $destPath) -Force | Out-Null
    Copy-Item -Path $_.FullName -Destination $destPath
}

# Compress the temporary directory into a ZIP file
if (Test-Path $backupZip) { Remove-Item $backupZip -Force }
Compress-Archive -Path "$tempDir\*" -DestinationPath $backupZip

# Clean up the temporary directory
Remove-Item -Recurse -Force $tempDir

Write-Output "Backup completed: $backupZip"
