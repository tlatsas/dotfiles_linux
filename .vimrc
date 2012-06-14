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
"set t_Co=256
colorscheme darkburn

" gvim options
if has('gui_running')
  set virtualedit=all
  set mouse=v
  set textwidth=80
  set lines=35 columns=90
  set guifont=Terminus\ 10
  set suffixes=.bak,~,.swp,.o,.pyc
  set fileencodings=utf-8
  set termencoding=utf-8
  set mouse=v
endif

" pathogen: https://github.com/tpope/vim-pathogen
source ~/.vim/bundle/pathogen/autoload/pathogen.vim
call pathogen#infect()
"filetype off
"call pathogen#runtime_append_all_bundles()
call pathogen#helptags()

"plugins
filetype plugin indent on

" hightlight after 80th column for python/C/perl/php
"highlight OverLength ctermbg=lightred ctermfg=black guibg=#FFD9D9
"au BufRead,BufNewFile *.py,*.c,*.h,*.pl,*.pm,*.php match OverLength /\%81v.\+/

" nerd tree
nnoremap <silent> <F9> :NERDTree<CR>

" tagbar
nnoremap <silent> <F10> :TagbarToggle<CR>

" LaTeX Preview
"autocmd FileType tex silent :! (file="%"; pdflatex % &>/dev/null && zathura "${file/.tex/.pdf}" &>/dev/null) &
"command! Reload :! (pdflatex % &>/dev/null) &
"au BufWritePost *.tex silent Reload

