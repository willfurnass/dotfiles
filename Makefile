SHELL := /bin/bash
SYM = ln --symbolic --no-target-directory --no-dereference --force --backup=numbered

all:    bash
.PHONY: bash

bash:
	[[ -d ${HOME}/.bash-git-prompt/.git ]] || git clone https://github.com/magicmonty/bash-git-prompt.git ${HOME}/.bash-git-prompt/ 
	pushd ${HOME}/.bash-git-prompt/ \
	&& git fetch --prune --all \
	&& git merge --ff-only origin/master \
	&& popd
