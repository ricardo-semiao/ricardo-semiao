# Configurations

This is the Configurations folder of my personal repository. Below, I list its contents.


## dotfiles

This folder keeps all the relevant configuration files (no, not only .dotfiles) of my PC. I do not use a symlink approach, I found best to create the [sync_dotfiles.ps1](dotfiles\sync_dotfiles.ps1) script and run it once in a while.


## setup

This folder contains scripts to set up my PC. Mainly, chocolatey code to get all the software I need. In the future I intent to add customization on windows settings themselves.

I have not spend too much time on this approach, and am thinking about some possible changes:

- Switching to [winget](https://learn.microsoft.com/en-us/windows/package-manager/winget/) instead of chocolatey.
- Adding install options for each software. I'd like to keep `C:\` cleaner, amongst software-specific wants.
- Adding a more explicative `.md` file, including links for software to download by hand, specially those that do not have enough chocolatey install options.
