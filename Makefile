all: inst-ackrc inst-bashrc inst-csirc inst-gitconfig inst-jupyter-css inst-matplotlibrc inst-vim inst-xmonad inst-xinitrc

inst-ackrc:
	ln -si `pwd`/ackrc ${HOME}/.ackrc
inst-csirc:
	ln -si `pwd`/csirc ${HOME}/.csirc
inst-gitconfig:
	ln -si `pwd`/gitconfig ${HOME}/.gitconfig
inst-jupyter-css:
	ln -si `pwd`/jupyter_notebook_theme.css ${HOME}/.jupyter/custom/custom.css
inst-marblemouse:
	sudo ln -si `pwd`/50-marblemouse.conf /usr/share/X11/xorg.conf.d/
inst-matplotlibrc:
	ln -si `pwd`/matplotlibrc ${HOME}/.config/matplotlib/matplotlibrc
inst-tmux:
	ln -si `pwd`/tmux.conf ${HOME}/.tmux.conf
inst-vim:
	ln -si `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	ln -si `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	ln -si `pwd`/vim-syntax ${HOME}/.vim/syntax
inst-xmonad:
	mkdir -p ${HOME}/.xmonad
	ln -si `pwd`/xmonad.hs ${HOME}/.xmonad/xmonad.hs
	ln -si `pwd`/xmobarrc ${HOME}/.xmobarrc
inst-xinitrc:
	ln -si `pwd`/xinitrc ${HOME}/.xinitrc
inst-todotxt:
	mkdir -p ${HOME}/.todo
	ln -si `pwd`/todo.cfg ${HOME}/.todo/config


# TO ADD:
#bashrc
#50-synaptics.conf
#99-nozap.conf
#lyx_user.bind
