# dotfiles

Config files for:

* `abcde` (CD ripper)
* `ack` (grep-like search tool)
* `beets` (music database manager)
* `csi` (Chicken Scheme)
* `docker`
* `emacs`
* `git`
* `gnupg`
* `i3` window manager plus associated utilities
* `inputrc`
* `irssi` (IRC client)
* `jupyter` (custom CSS)
* `lyx` (key bindings for LaTeX-like editor)
* `matplotlib` (Pyton plotting library)
* `mimeapps`
* `mksh` shell
* `mpd` (music playing daemon)
* `newsboat` (feed reader)
* `ranger` file manager (with w3m-powered image previews)
* `R`
* `rofi`
* `ssh-agent`
* `tmux` (terminal multiplexer)
* `todotxt`
* `vim`
* `weechat` (IRC client)
* `xrandr`
* `xinitrc`
* `Xresources`
* `zathura` (PDF reader)

## Installation

Install GNU Stow then run `make -B`. 
GNU Stow will then create symlinks from files in this dir to specific places in your home directory 
but will refuse to clobber any existing files or any existsing symlinks it didn't create.
