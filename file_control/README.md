# File Control

This is the File Control folder of my personal repository. Below, I list its contents.

There are three scripts, that help me control the files in my machines. All of them output file path analytics to a "text/" folder, but that is not uploaded to GitHub.

- [find_paths.ps1](file_control\find_paths.ps1) is used to find folder names that aren't in conformity with my chosen style: sentence case for general folders, and snake-case for programming projects.
- [find_prog_projects.ps1](file_control\record_prog_projects.ps1) is used to find folders that contain programming projects, i.e., have a ".RProj" or a ".code-workspace" file in them.
- [find_symlinks.ps1](file_control\find_symlinks.ps1) is used to find symlinks in my machine, and output whether they are valid or have been broken.
- [count_extensions.ps1](file_control\count_extensions.ps1) is used to count the number of files by extension type, in a given directory.
