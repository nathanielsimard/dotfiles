""" Basic Settings
set nu
set relativenumber
set nowrap
let mapleader = ' '
syntax on
set termguicolors

""" Plugins
call plug#begin()

Plug 'sheerun/vim-polyglot'
Plug 'neomake/neomake'

"Plug 'ayu-theme/ayu-vim'
"Plug 'morhetz/gruvbox'
Plug 'tomasiser/vim-code-dark'

Plug 'psf/black'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'junegunn/fzf'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

""" Deoplete Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:deoplete#enable_at_startup = 1

""" Theme
let g:airline_theme='codedark'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1                                                                                                                                                                                                                                  
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1 
colorscheme codedark

""" Language Server Settings
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['~/.config/nvim/start-python.sh'],
    \ }
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0

""" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_open_list = 1
let g:neomake_python_enabled_makers = ['flake8', 'mypy']

""" Neomake Keybindings
nnoremap <leader>e :lnext<CR>
nnoremap <leader><S-e> :lprev<CR>

""" Language Client Server Keybindings
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <leader>ld :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>lg :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lh :call LanguageClient_textDocument_references()<CR>
nnoremap <leader>lf :Black<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_documentHighlight()<CR>

""" NERDTree Keybindings
nnoremap <leader>tt :NERDTreeToggle<CR>

""" FZF Keybindings
nnoremap <leader>ff :FZF<CR>

""" Window Navigation Keybindings
nnoremap <leader>wq :bd<Enter>
nnoremap <leader>wrl :vertical resize +5<Enter>
nnoremap <leader>wrh :vertical resize -5<Enter>
nnoremap <leader>wrj :res +5<Enter>
nnoremap <leader>wrk :res -5<Enter>
nnoremap <leader>wr<Right> :vertical resize +5<Enter>
nnoremap <leader>wr<Left> :vertical resize -5<Enter>
nnoremap <leader>wml <C-w>L 
nnoremap <leader>wm<Right> <C-w>L
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wv <C-w>v
nnoremap <leader>wb <C-w>b
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
nnoremap <leader>bl :bnext<CR>
nnoremap <leader>bh :bprevious<CR>
