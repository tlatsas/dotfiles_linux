" vim configuration file
set nocompatible
set showmatch
set incsearch
syntax enable
set history=100
set backspace=eol,start,indent
set ruler
set number
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab
set wildmenu
set showcmd
set autoindent
set smartindent
set list listchars=tab:→\ ,trail:·

" colors
set t_Co=256
colorscheme wombat_t

" gvim options
if has('gui_running')
  set virtualedit=all
  set mouse=v
  set textwidth=80
  set lines=35 columns=90
  set guifont=Terminus\ 10
  colors wombat_g
  set suffixes=.bak,~,.swp,.o,.pyc
  set fileencodings=utf-8
  set termencoding=utf-8
  set mouse=v
endif

"plugins
filetype plugin on

" key bindings
nnoremap <silent> <F8> :TlistToggle<CR>

" hightlight after 80th column for python/C/perl/php
highlight OverLength ctermbg=lightred ctermfg=black guibg=#FFD9D9
au BufRead,BufNewFile *.py,*.c,*.h,*.pl,*.pm,*.php match OverLength /\%81v.\+/

" Vim Addon Manager
" https://github.com/MarcWeber/vim-addon-manager.git
fun SetupVAM()
  set runtimepath+=~/.vim-addons/vim-addon-manager
    call vam#ActivateAddons([
                            \ 'snipmate',
                            \ 'snipmate-snippets',
                            \ 'surround',
                            \ 'vim-latex',
                            \ 'The_NERD_tree',
                            \ 'The_NERD_Commenter',
                            \ 'CSApprox',
                            \ 'minibufexplorer_-_Elegant_buffer_explorer',
                            \ 'taglist'], {'auto_install' : 0})
endf

call SetupVAM()
