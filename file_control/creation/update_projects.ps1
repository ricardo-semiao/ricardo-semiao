$projects = @{
    morphdown = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\morphdown"
    mtsdesc = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\mtsdesc"
    phyopt = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\phyopt"
    course_ccia = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\Cursos cs\course-ccia"
    course_rfcd = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\Cursos r\course-rfcd"
    course_paaml = "C:\Users\ricar\OneDrive\A-Trabalho\Prog\Cursos python\course-paaml"
}


function RunAndPush {
    param (
        [string]$Project,
        [scriptblock[]]$Commands,
        [string]$Message
    )

    Set-Location -Path $projects[$project]

    if (-not $projects.ContainsKey($Project)) {
        Write-Host "Project '$Project' not found in the projects list."
        return
    }

    Write-Host "Running commands for $($Project):"
    foreach ($command in $Commands) {
        Write-Host "  -> $command"
        & $command
    }

    Write-Host "Changed files in $($Project):"
    git status --porcelain
    $runDiffTool = Read-Host "Do you want to run 'git difftool' to review changes? (y/n)"
    if ($runDiffTool -ieq "y") {
        git difftool
    }

    $confirmation = Read-Host "Do you want to continue with the changes? (y/n)"
    if ($confirmation -ne "y") {
        Write-Host "Operation canceled by the user."
        return
    }

    $amendOption = Read-Host "Do you want to amend the last commit and push with `--force-with-lease`? (y/n)"
    Write-Host "You chose to $(if ($amendOption -ieq "y") { 'amend the last commit' } else { 'create a new commit' })."

    $confirmation = Read-Host "Are you sure about this choice? (y/n)"
    if ($confirmation -ne "y") {
        $amendOption = Read-Host "Do you want to amend the last commit and push with `--force-with-lease`? (y/n)"
    }

    if ($amendOption -ne "y") {
        if (-not $Message) { $Message = Read-Host "Enter a commit message"}
        while ($true) {
            Write-Host "Current commit message: '$Message'"
            $confirmation = Read-Host "Are you satisfied with this message? (y/n)"
            if ($confirmation -ieq "y") { break }
            $Message = Read-Host "Enter a new commit message"
        }
    }

    git add .
    if ($amendOption -eq "y") {
        git commit --amend --no-edit
        git push --force-with-lease
    } else {
        git commit -m "$Message"
        git push
    }

    Write-Host "Pushed changes to $($Project) repository"
}


function Update-Projects {
    param (
        [string]$Project,
        [string]$Message
    )

    $run = @{
        pkgdown = @(
            { set RSTUDIO_PANDOC "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools" }
            { Rscript -e "unlink('docs', recursive = TRUE)" }
            { Rscript -e "pkgdown::build_site(preview = FALSE)" }
        )
        quartobook = @(
            { quarto render }
        )
        bookdown = @(
            { set RSTUDIO_PANDOC "C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools" }
            { Rscript -e "bookdown::render_book(clean = FALSE)" }
        )
    }

    if ($Project -in @('morphdown', 'mtsdesc', 'phyopt')) {
        RunAndPush $Project $run['pkgdown'] $Message
    }
    elseif ($Project -in @('course_ccia', 'course_paaml')) {
        RunAndPush $Project $run['quartobook'] $Message
    }
    elseif ($Project -in @('course_rfcd')) {
        RunAndPush $Project $run['bookdown'] $Message
    } else {
        Write-Host "No commands to run for project '$Project'."
    }
}


# Application:
$ps = @('morphdown', 'mtsdesc', 'phyopt', 'course_ccia', 'course_rfcd', 'course_paaml')
$project = $ps[6 - 1]; Set-Location -Path $projects[$project]
Update-Projects $project
