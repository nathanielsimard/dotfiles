call plug#begin('~/.vim/plugged')

Plug 'https://github.com/scrooloose/nerdtree.git'

Plug 'https://github.com/scrooloose/syntastic.git'

Plug 'klen/python-mode'

Plug 'marijnh/tern_for_vim'

Plug 'chriskempson/base16-vim'

Plug 'vim-airline/vim-airline'

Plug 'vim-airline/vim-airline-themes'

Plug 'Valloric/YouCompleteMe'

Plug 'vim-scripts/indentpython.vim'

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
set clipboard=unnamed,unnamedplus

"Performance
set ttyfast
set lazyredraw
set nowrap

"set changing mode fast
set ttimeoutlen=0

" Enable CursorLine
set cursorline

" Default Colors for CursorLine
highlight  CursorLine ctermbg=None ctermfg=None cterm=None

" Change Color when entering Insert Mode
autocmd InsertEnter * highlight  CursorLine ctermbg=None cterm=underline ctermfg=None

" Revert Color to default when leaving Insert Mode
autocmd InsertLeave * highlight  CursorLine ctermbg=None ctermfg=None cterm=None

" for command mode
nnoremap <S-Tab> <<

" for insert mode
nnoremap <S-Tab> <C-d>

py << EOF
import os
import sys
if 'VIRTUAL_ENV' in os.environ:
    project_base_dir = os.environ['VIRTUAL_ENV']
    activate_this = os.path.join(project_base_dir, 'bin/activate_this.py')
    execfile(activate_this, dict(__file__=activate_this))
EOF
