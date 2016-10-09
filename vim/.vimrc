call plug#begin('~/.vim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'

Plug 'https://github.com/scrooloose/syntastic.git'

Plug 'chriskempson/base16-vim'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'Valloric/YouCompleteMe'

cal plug#end()

set nu
set relativenumber

syntax enable
let base16colorspace=256
set t_Co=256
set background=dark
colorscheme base16-default-dark

"let g:airline#extensions#tabline#enabled=1
let g:airline1extensionstabline#left_sep = ' '
let g:airline1extensionstabline#left_alt_sep = '|'
set laststatus=2

set tabstop=4 shiftwidth=4 expandtab
set clipboard=unnamedplus

"Performance
set ttyfast
set lazyredraw
set nowrap
