# File Control

This is the File Control folder of my personal repository. Here I have `.ps1` scripts that help me control the files in my machines. Below, I list its contents.

- [ps1_style.md](file_control\ps1_style.md): markdown directories for the conventions I use for my PowerShell scripts.
- [utils.ps1](file_control\utils.ps1): a script that contains functions that I use in my other scripts. Mainly, the `GetDirsChildren` that gets files or folders from a list of directories, with some filtering functionality.
- The outputs of the scripts go to a "output/" folder, but that is not uploaded to GitHub.


## Creating

- [update_projects.ps1](file_control\creation\update_projects.ps1): Many of my projects depend on the themes this repository and the CSS/JS in [ricardo-semiao.github.io](https://github.com/ricardo-semiao/ricardo-semiao.github.io). When these are updated, I sometimes need to update the projects too. This script globally access that list of projects, re-render them, and pushes the changes to GitHub. In the future I want to include a stashing functionality to restore initial states if the changes are not wanted.
- [create_recursive_hardlink.ps1](file_control\creation\create_recursive_hardlink.ps1): Creates hard links recursively, preserving folder structure.
- [create_url_file.ps1](file_control\creation\create_url_file.ps1): Generates `.url` files from given URLs.
- [save_folder_structure.ps1](file_control\creation\save_folder_structure.ps1): Saves the folder structure of a directory to a CSV file.
- [zip_folder.ps1](file_control\creation\zip_folder.ps1): Compresses a folder into a ZIP file, with options to exclude certain file types.


## Analysis

- [count_extensions.ps1](file_control\analisys\count_extensions.ps1): Counts the number of files by extension type in a list of directories.
- [find_badsnake_folders.ps1](file_control\analisys\find_badsnake_folders.ps1): Identifies folders with names that do not conform to snake_case.
- [find_kebab_folders.ps1](file_control\analisys\find_kebab_folders.ps1): Finds folders with names that conform to kebab-case.
- [find_project_folders.ps1](file_control\analisys\find_project_folders.ps1): Identifies folders containing programming projects (e.g., `.RProj` or `.code-workspace` files).
- [find_filelinks.ps1](file_control\analisys\find_filelinks.ps1): Finds file links (e.g., symbolic links, hard links) and checks their validity.
- [grep_file_sizes.ps1](file_control\analisys\grep_file_sizes.ps1): Extracts file sizes and outputs them to a CSV file.
