# dotfiles

Config files for:

* `kanshi` (auto-config for sway displays)
* `mpd` (music playing daemon)
* `spacemacs`
* `ssh-agent`
* `vim`

## Installation

Install GNU Stow then run `make -B`. 
GNU Stow will then create symlinks from files in this dir to specific places in your home directory 
but will refuse to clobber any existing files or any existsing symlinks it didn't create.
