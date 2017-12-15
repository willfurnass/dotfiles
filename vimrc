""""""""""""""""""""""""""
" Disable vi compatibility
""""""""""""""""""""""""""
set nocompatible

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting and per-filetype indentation
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax on

"""""""""""""""""
" Vim plug config
"""""""""""""""""
" Autoinstall plug if not already installed:
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall
endif
call plug#begin()

"""""""""""""""""""
" Async Lint Engine
"""""""""""""""""""
Plug 'w0rp/ale'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
let g:deoplete#enable_at_startup = 1

""""""""""""
" Commenting
""""""""""""
Plug 'tpope/vim-commentary'
" - 'gcc' to comment out a line (takes a count)
" - 'gc' to comment out the target of a motion (for example, 'gcap' to comment out a paragraph), 
" - 'gc' in visual mode to comment out the selection
" - 'gc' in operator pending mode to target a comment. 
" - You can also use it as a command, either with a range like ':7,17Commentary' 
" - or as part of a ':global' invocation like with ':g/TODO/Commentary'. 
" - uncomments too: The above maps actually toggle, and gcgc uncomments a set of adjacent commented lines.


"""""""""""""""""""""""""""""""""""""
" Generate/format markdown/rst tables
"""""""""""""""""""""""""""""""""""""
Plug 'dhruvasagar/vim-table-mode'
" leader tm (:TableModeToggle) - start creating table
" leader tt (:Tableize) - (re)format as table
" Much more functionality documented at https://github.com/dhruvasagar/vim-table-mode

"""""""""""""""""""""""""""""""""""""""""""""""""
" Status/tabline that supports many other plugins
"""""""""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='solarized'

""""""""""""""""""""""
" Tree explorer plugin
""""""""""""""""""""""
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
" Open NERDTree automatically when vim starts up on opening a directory
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
" Map a specific key or shortcut to open NERDTree
map <C-n> :NERDTreeToggle<CR>
" Close vim if the only window left open is a NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


"""""""""""""
" Git wrapper
"""""""""""""
Plug 'tpope/vim-fugitive'
" If fugitive.vim is the Git, rhubarb.vim is the Hub. 
Plug 'tpope/vim-rhubarb'

""""""""""""""""""""
"Git per-line status
""""""""""""""""""""
Plug 'mhinz/vim-signify'

""""""""""""""""""
" reStructuredText
""""""""""""""""""
Plug 'Rykka/InstantRst'
" Inside a rst buffer:
" :InstantRst[!]   Preview current buffer. Add ! to preview ALL rst buffer.
" :StopInstantRst[!]   Stop Preview current buffer Add ! to stop preview ALL rst buffer. 

" .rst settings for vim-table-mode plugin
"autocmd FileType rst let table_mode_corner_corner='+' table_mode_header_fillchar='='

""""""""""
" Markdown
""""""""""
" NB using built-in Markdown support (by tpope) rather than
" plasticboy/vim-markdown due to issue #126 with the latter

" Ensure files with a variety of extensions all recognised as Markdown
au BufNewFile,BufReadPost *.{md,mdown,mkd,mkdn,markdown,mdwn} set filetype=markdown
" Enable syntax highlighting and indentation for Markdown
autocmd FileType markdown setlocal autoindent formatoptions-=or nocindent

" Support for highlighting Github-style Markdown's fenced code blocks
let g:markdown_fenced_languages = ['html', 'python', 'bash=sh']
"
" .md settings for vim-table-mode plugin
"autocmd FileType md letlocal g:table_mode_corner_corner='|'

" Folding in Markdown; disable by default
autocmd FileType markdown setlocal nofoldenable

" Vim plugin for Godown Markdown Previewer
Plug 'davinche/godown-vim', { 'for': 'markdown' }
let g:godown_autorun = 0
" launch the Godown server and preview your markdown
":GodownPreview
" stop the Godown server
":GodownKill
" Toggle the Godown server
":GodownToggle
" Live Preview
":GodownLiveToggle
"
" Plugin for generating ToCs for Markdown docs
Plug 'mzlogin/vim-markdown-toc'
":GenTocGFM - Generate table of contents in GFM link style.
":GenTocRedcarpet - Generate table of contents in Redcarpet link style. 
let g:vmt_auto_update_on_save = 0
let g:vmt_dont_insert_fence = 0

""""""""
" Python
""""""""
" See https://github.com/python-mode/python-mode/pull/602 for why
" python-mode can't be enabled in vimdiff
if !&diff
    Plug 'klen/python-mode'
endif
" python-mode includes pylint, rope, pydoc, pyflakes, pep8, and mccabe for
" features like static analysis, refactoring, folding, completion,
" documentation, and more.

" Turn off Rope autoimport until pymode github issue 525 fixed
" let g:pymode_rope_autoimport = 0
" Not doing the trick, so disable Rope alltogether
let g:pymode_rope = 0

" Other Python Mode options:
"   Trim unused white spaces on save
let g:pymode_trim_whitespaces = 1
" let g:pymode_python = 'python3'
let g:pymode_indent = 1
let g:pymode_folding = 1
let g:pymode_motion = 1
"   Show docs for current word by pydoc using 'K'
let g:pymode_doc = 1
"   Automatic virtualenv detection
let g:pymode_virtualenv = 1
"   Run current buffer/selection with '<leader>r'
let g:pymode_run = 1
"   Insert/remove breakpoint with '<leader>b'
let g:pymode_breakpoint = 1

" virtualenv support
Plug 'jmcantrell/vim-virtualenv'

" Syntax file for cython
Plug 'tshirtman/vim-cython'

""""""""
" Matlab
""""""""
Plug 'vim-scripts/MatlabFilesEdition'
" - syntax highlighting
" - correct settings for matchit.vim for matching if/end and for/end blocks
"   (using e.g. %),
" - correct indentation, integration of mlint (Matlab code checker) with the
"   :make command,
" - tag support,
" - help file.

"""""""""
" Clojure
"""""""""
" Static Clojure support
Plug 'guns/vim-clojure-static', { 'for': 'clojure' }
" - Augmentable syntax highlighting for Clojure and ClojureScript buffers.
" - Configurable Clojure-specific indentation.
" - Basic insert mode completion for special forms and public vars in
"   clojure.core.
" - 3rd party extensions inc. Rainbow Parentheses and Extended Syntax
"   Highlighting

" Connect to Clojure (n)REPL
Plug 'tpope/vim-fireplace', { 'for': 'clojure' }

" Static Vim support for Leiningen and Boot,
" the latter being build tooling for Clojure
Plug 'tpope/vim-salve', { 'for': 'clojure' }

"Structured editing of Lisp S-expressions in Vim.
Plug 'vim-scripts/paredit.vim'
" Useful for Clojure coding.

""""""""""""""
" Editorconfig
""""""""""""""
" EditorConfig helps developers define and maintain consistent coding styles
" between different editors and IDEs.
Plug 'editorconfig/editorconfig-vim'

"""""""
" Scala
"""""""
Plug 'derekwyatt/vim-scala'

""""""""""""""""""""""""
" Underlining / headings
""""""""""""""""""""""""
Plug 'drmikehenry/vim-extline'
"vim-extline: The following mappings apply in Visual and Insert modes (but,
"notably, NOT in Normal mode):
"CTRL-L CTRL-L Auto-line update
"CTRL-L CTRL-H Horizontal line update
"CTRL-L CTRL-U Change to underlined title
"CTRL-L CTRL-O Change to overlined title
"CTRL-L CTRL-I Change to underlined and overlined title
"CTRL-L = Force Section heading (level 1)
"CTRL-L 1 or CTRL-L - Force Subsection heading (level 2)
"CTRL-L 2 or CTRL-L ^ Force Subsubsection heading (level 3)
"CTRL-L 3 or CTRL-L " Force Paragraph heading (level 4)
"CTRL-L 4 or CTRL-L ' Force level 5 heading (level 5)
"CTRL-L 5

""""""""""""""
" Tag browsing
""""""""""""""
"Source code browser plugin
Plug 'vim-scripts/taglist.vim'

let Tlist_Ctags_Cmd = "/usr/bin/ctags"
let Tlist_WinWidth = 35

" Binding to show/hide tag list
nnoremap <F4> :TlistToggle<cr>

" Binding to regenerate ctags file
nnoremap <F8> :!/usr/bin/ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"""""""""""""""
" Colour scheme
"""""""""""""""
"Well-designed 16-color palette (see http://ethanschoonover.com/solarized)
Plug 'altercation/vim-colors-solarized'

""""""""""""""""""
" Todo.txt support
""""""""""""""""""
Plug 'freitass/todo.txt-vim'
"localleader is \ by default
"<localleader>s Sort the file
"<localleader>s+ Sort the file on +Projects
"<localleader>s@ Sort the file on @Contexts
"<localleader>sd Sort the file on dates
"<localleader>sdd Sort the file on due dates
"<localleader>j Decrease the priority of the current line
"<localleader>k Increase the priority of the current line
"<localleader>a Add the priority (A) to the current line
"<localleader>b Add the priority (B) to the current line
"<localleader>c Add the priority (C) to the current line
"<localleader>d Set current task's creation date to the current date
"date<tab> (Insert mode) Insert the current date
"<localleader>x Mark current task as done
"<localleader>X Mark all tasks as done
"<localleader>D Move completed tasks to done.txt

""""""""""""""""""""""""""""""
" Enclosing characters/strings
""""""""""""""""""""""""""""""
Plug 'tpope/vim-surround' | Plug 'tpope/vim-repeat'
"Add, change and delete 'surroundings' (parentheses, brackets, quotes, XML
"tags, and more)
" cs"' change double to single quotes
" cs'<q> change single quotes to html tag quotes
" cst" change html tag pair to double quotes
" ds" delete quotes
" ysiw] surround unsurrounded word in square brackets
" cs]{ change surroundings from [] to {} (use { if want extra space)
" yssb or yss) wrap line in parentheses
" ds{ds) revert to original text
" ysiw<em> emphasise word
" Visual mode: select text then e.g. S<p class="important">
"
"The dependency vim-repeat allows repeating of supported plugin maps with ".".
"Allows repeating of e.g. surround.vim commands

"""""""""
" Folding
"""""""""
Plug 'embear/vim-foldsearch'
"Fold all but lines matching a pattern
"Useful for filtering when viewing todo.txt
" :Fs Show lines which contain the word under the cursor.
" :Fp Show the lines that contain the given regular expression.
" :FS Show the lines that contain spelling errors.
" :Fl Fold again with the last used pattern
" :Fc Show or modify current context lines around matching pattern.
" :Fi Increment context by one line.
" :Fd Decrement context by one line.
" :Fe Set modified fold options to their previous value and end foldsearch.

"""""""""""""""""""
" Buffer management
"""""""""""""""""""
" Simple buffer overview
Plug 'weynhamz/vim-plugin-minibufexpl'

" Enable hidden buffers so can switch buffers without saving
set hidden

" Enable fast buffer switching
nnoremap <leader>n :bn<cr>
nnoremap <leader>p :bp<cr>

""""""""""""""""""""""""
" Recovery of swap files
""""""""""""""""""""""""
Plug 'chrisbra/Recover.vim'
"Diff (and allow merging) of on-disk file and version recovered from swap file
"By default this plugin is enabled. To disable it, use :RecoverPluginDisable
"To enable this plugin again, use :RecoverPluginEnable
"If you are finished, you can close the diff version and close the window, by
"issuing :diffoff! and :close in the window, that contains the on-disk version
"of the file. Be sure to save the recovered version of your file and
"afterwards you can safely remove the swap file.
"In the recovered window, the command :FinishRecovery deletes the swapfile
"closes the diff window and finishes everything up. Alternatively you can also
"use the command :RecoveryPluginFinish
"For help: ':h RecoverPlugin-manual'

""""""""""""""""""""""""""
" Autocompletion for C/C++
""""""""""""""""""""""""""
" Autocomplete C/C++ code using clang.
" NB need to be clear about namespaces.
Plug 'Rip-Rip/clang_complete', { 'for': ['c', 'c++' ] }

""""""""""""""""""""""""""""""""""""""""""
" Make % match more than just single chars
""""""""""""""""""""""""""""""""""""""""""
Plug 'vim-scripts/matchit.zip'
" Can match words and regexes.
" Also, matching treats strings and comments (as recognized by the
" syntax highlighting mechanism) intelligently.
" The default ftplugins include settings for several languages:
" Ada, ASP with VBS, Csh, DTD, Essbase, Fortran, HTML, JSP
" (same as HTML), LaTeX, Lua, Pascal, SGML, Shell, Tcsh, Vim, XML.

""""""""""""""""
" Puppet support
""""""""""""""""
" Formatting based on the latest Puppetlabs Style Guide
" Syntax highlighting
" Automatic => alignment (can disable with let g:puppet_align_hashes = 0)
Plug 'rodjek/vim-puppet'

""""""""
" vim-go
""""""""
Plug 'fatih/vim-go'
" Compile your package with :GoBuild, install it with :GoInstall or test it with :GoTest. Run a single tests with :GoTestFunc).
" Quickly execute your current file(s) with :GoRun.
" Improved syntax highlighting and folding.
" Completion support via gocode.
" gofmt or goimports on save keeps the cursor position and undo history.
" Go to symbol/declaration with :GoDef.
" Look up documentation with :GoDoc or :GoDocBrowser.
" Easily import packages via :GoImport, remove them via :GoDrop.
" Automatic GOPATH detection which works with gb and godep. Change or display GOPATH with :GoPath.
" See which code is covered by tests with :GoCoverage.
" Add or remove tags on struct fields with :GoAddTags and :GoRemoveTags.
" Call gometalinter with :GoMetaLinter to invoke all possible linters (golint, vet, errcheck, deadcode, etc.) and put the result in the quickfix or location list.
" Lint your code with :GoLint, run your code through :GoVet to catch static errors, or make sure errors are checked with :GoErrCheck.
" Advanced source analysis tools utilizing guru, such as :GoImplements, :GoCallees, and :GoReferrers.
" Precise type-safe renaming of identifiers with :GoRename.
" ... and many more! Please see doc/vim-go.txt for more information.


" Add plugins to &runtimepath
call plug#end()

"""""""""""""""""""""""""""""""""
" Disable expandtab for Makefiles
"""""""""""""""""""""""""""""""""
autocmd FileType make setlocal noexpandtab shiftwidth=8 softtabstop=0

""""""""""""""""
" Line numbering
""""""""""""""""
" Toggle with F3
noremap <F3> :set invnumber<CR>
inoremap <F3> <C-O>:set invnumber<CR>

""""""""""""""""
" (G)UI settings
""""""""""""""""
set laststatus=2 " Show status line even when only one window shown
set ruler " Display the cursor position on the last line of the screen or in
          " the status line of a window
set showmode " Show the mode that vim is in (Insert, Replace, Visual)
set hlsearch " Highlight searches
set bg=dark " Set background to dark
if has('gui_running') " Set GUI font and colorscheme
  set guifont=Hack\ 10,OpenDyslexicMono\ 9,Ubuntu\ Mono\ 12,Courier_New:h10:cANSI
  colorscheme solarized
endif

"""""""""""""""""""""""""""""""""""""
" Movement, spacing, indents, pasting
"""""""""""""""""""""""""""""""""""""
set expandtab
set shiftwidth=4
set softtabstop=4
set cindent
set backspace=2
" Paste blocks without autoindent introducing extraneous spacing
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
autocmd FileType make setlocal noexpandtab
" Disable cursor keys
nnoremap <up>    <nop>
nnoremap <down>  <nop>
nnoremap <left>  <nop>
nnoremap <right> <nop>
inoremap <up>    <nop>
inoremap <down>  <nop>
inoremap <left>  <nop>
inoremap <right> <nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable parsing of vim modelines at the top of source files
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set modeline

"""""""""""""""""""""""""""""""""""""""""""""
" Insert date and time (F5) or just date (F6)
"""""""""""""""""""""""""""""""""""""""""""""
nnoremap <F5> "=strftime("%Y-%m-%d %H:%M")<CR>P
inoremap <F5> <C-R>=strftime("%Y-%m-%d %H:%M")<CR>
nnoremap <F6> "=strftime("%Y-%m-%d")<CR>P
inoremap <F6> <C-R>=strftime("%Y-%m-%d")<CR>

"""""""""""""""""""""""""""""""""
" Toggle automatic spell checking
"""""""""""""""""""""""""""""""""
nnoremap <F7> :setlocal spell! spelllang=en_gb<CR>
inoremap <F7> <Esc>:setlocal spell! spelllang=en_gb<CR>a

""""""""""""""""""""""""""
" Browse to links using gx
""""""""""""""""""""""""""
let g:netrw_browsex_viewer = "/usr/bin/x-www-browser"

"""""""""""
" Encodings
"""""""""""
set encoding=utf-8  " The encoding displayed.
set fileencoding=utf-8  " The encoding written to file.

"""""""""""""""""""""""""""""""
" Show size of visual selection
"""""""""""""""""""""""""""""""
set showcmd

""""""""""""""
" Puppet style 
""""""""""""""
" (https://docs.puppet.com/guides/style_guide.html#parameter-defaults)
autocmd FileType puppet setlocal shiftwidth=2 softtabstop=2 expandtab

"""""""""""""""""""""""""""""""""""""""""""""""
" autocomplete filenames in similar way to bash
"""""""""""""""""""""""""""""""""""""""""""""""
" When you type the first tab hit will complete as much as possible, the
" second tab hit will provide a list, the third and subsequent tabs will cycle
" through completion options so you can complete the file without further keys
set wildmode=longest,list,full
set wildmenu

""""""""""""""""""""""""""""""""""""""""""""""
" Mutt: wrap paragraphs using soft line breaks
""""""""""""""""""""""""""""""""""""""""""""""
" Useful if using format=flowed (RFC 3676) in vim
au BufRead /tmp/mutt-* set fo+=w
