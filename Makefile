SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all: abcde ackrc bash beets csirc gitconfig jupyter-css matplotlibrc mpd rprofile todotxt tmux vim weechat xinitrc 

abcde:
	 $(SYM) `pwd`/abcde.conf ${HOME}/.abcde.conf
ackrc:
	 $(SYM) `pwd`/ackrc ${HOME}/.ackrc
bash:
	[[ -d ${HOME}/.bash-git-prompt/ ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt/ 
	pushd ${HOME}/.bash-git-prompt/ \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
beets:
	mkdir -p ${HOME}/.config/beets
	$(SYM) `pwd`/beets_config.yaml ${HOME}/.config/beets/config.yaml
csirc:
	$(SYM) `pwd`/csirc ${HOME}/.csirc
gitconfig:
	$(SYM) `pwd`/gitconfig ${HOME}/.gitconfig
jupyter-css:
	mkdir -p ${HOME}/.jupyter/custom
	$(SYM) `pwd`/jupyter_notebook_theme.css ${HOME}/.jupyter/custom/custom.css
matplotlibrc:
	mkdir -p ${HOME}/.config/matplotlib/
	$(SYM) `pwd`/matplotlibrc ${HOME}/.config/matplotlib/matplotlibrc
mpd:
	mkdir -p ${HOME}/.config/mpd
	$(SYM) `pwd`/mpd/mpd.conf ${HOME}/.config/mpd/mpd.conf
	mkdir -p ${HOME}/.config/mpdscribble
	$(SYM) `pwd`/mpd/mpdscribble.conf.anon ${HOME}/.config/mpdscribble/mpdscribble.conf.anon
	$(SYM) ${HOME}/.config/mpdscribble ${HOME}/.mpdscribble
	mkdir -p ${HOME}/.config/ncmpcpp/
	$(SYM) `pwd`/mpd/ncmpcpp_config ${HOME}/.config/ncmpcpp/config
rprofile:
	$(SYM) `pwd`/RProfile ${HOME}/.RProfile
todotxt:
	mkdir -p ${HOME}/.todo
	$(SYM) `pwd`/todo.cfg ${HOME}/.todo/config
	$(SYM) `pwd`/todo.actions.d ${HOME}/.todo.actions.d
tmux:
	[ -d ~/.tmux/plugins/tpm ] || git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
	pushd ~/.tmux/plugins/tpm \
	    && git fetch --prune --all \
	    && git merge --ff-only origin/master \
	    && popd
	$(SYM) `pwd`/tmux.conf ${HOME}/.tmux.conf
	${HOME}/.tmux/plugins/tpm/bin/install_plugins
	${HOME}/.tmux/plugins/tpm/bin/update_plugins all
vim:
	$(SYM) `pwd`/vimrc ${HOME}/.vimrc
	mkdir -p ${HOME}/.vim
	$(SYM) `pwd`/vim-ftplugin ${HOME}/.vim/ftplugin
	$(SYM) `pwd`/vim-syntax ${HOME}/.vim/syntax
	$(SYM) `pwd`/vim-after ${HOME}/.vim/after
	$(SYM) `pwd`/vim-autoload ${HOME}/.vim/autoload
	mkdir -p ${HOME}/.config
	$(SYM) ${HOME}/.vim ${HOME}/.config/nvim
	$(SYM) ${HOME}/.vimrc ${HOME}/.config/nvim/init.vim
	type -f pip |> /dev/null && pip list --user | grep -q neovim || pip install --user neovim
weechat:
	mkdir -p ${HOME}/.weechat/
	$(SYM) `pwd`/weechat/irc.conf ${HOME}/.weechat/irc.conf
	$(SYM) `pwd`/weechat/weechat.conf ${HOME}/.weechat/weechat.conf
xinitrc:
	$(SYM) `pwd`/xinitrc ${HOME}/.xinitrc


# TO ADD:
#bashrc
#50-synaptics.conf
#99-nozap.conf
#lyx_user.bind
