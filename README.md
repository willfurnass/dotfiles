# dotfiles

Config files for:

* `abcde` (CD ripper)
* `ack` (grep-like search tool)
* `beets` (music database manager)
* `csi` (Chicken Scheme)
* `extract_url` (used by Mutt)
* `emacs`
* `git`
* `gpg-agent`
* `i3` window manager plus associated utilities
* `irssi` (IRC client)
* `jupyter` (custom CSS)
* `lyx` (key bindings for LaTeX-like editor)
* `matplotlib` (Pyton plotting library)
* `mimeapps`
* `mksh` shell
* `mpd` (music playing daemon)
* `mutt` (mail client)
* `newsboat` (feed reader)
* `ranger` file manager (with w3m-powered image previews)
* `R`
* `ssh-agent`
* `tmux` (terminal multiplexer)
* `todotxt`
* `vim`
* `weechat` (IRC client)
* `xinitrc`
* `Xresources`

## Installation

Install GNU Stow then run `make -B`. 
GNU Stow will then create symlinks from files in this dir to specific places in your home directory 
but will refuse to clobber any existing files or any existsing symlinks it didn't create.
