call plug#begin()
""" Linting and Test
Plug 'neomake/neomake'
Plug 'janko/vim-test'

""" Better Syntax
Plug 'sheerun/vim-polyglot'
Plug 'chriskempson/base16-vim'

""" Python Plugins
Plug 'psf/black'
Plug 'heavenshell/vim-pydocstring'

""" Autocomple
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }


""" Utilities
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'junegunn/fzf'
Plug 'editorconfig/editorconfig-vim'
Plug 'mileszs/ack.vim'

""" Language Server Protocal Support
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

call plug#end()

""" Basic Settings
set tabstop=4 shiftwidth=4 expandtab 
set nu
set relativenumber
set nowrap
let mapleader = ' '
syntax on

""" Deoplete Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:deoplete#enable_at_startup = 1

""" Airline Settings
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1 

""" Theming
set background=dark
set termguicolors
let g:airline_theme='base16'
colorscheme base16-default-dark

""" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_open_list = 1
let g:neomake_check_on_open = 1
let g:neomake_python_enabled_makers = ['flake8', 'mypy']
let g:neomake_javascript_enabled_makers = ['eslint']

""" Neomake Keybindings
nnoremap <leader>e :lnext<CR>
nnoremap <leader><S-e> :lprev<CR>

""" Language Server Settings
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['python', '-m', 'pyls'],
    \ 'tex': ['~/.local/bin/tex-lsp'],
    \ 'javascript': ['javascript-typescript-stdio', '-l', '/tmp/javascript-typescript-stdio.log'],
    \ }
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0

""" Language Client Server Keybindings
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <leader>ld :call LanguageClient#textDocument_hover()<CR>
nnoremap <leader>lg :call LanguageClient#textDocument_definition()<CR>
nnoremap <leader>lr :call LanguageClient#textDocument_rename()<CR>
nnoremap <leader>lh :call LanguageClient_textDocument_references()<CR>
nnoremap <leader>lc :call LanguageClient#textDocument_documentHighlight()<CR>

""" NERDTree Keybindings
nnoremap <leader>te :NERDTreeFocus<CR>

""" FZF Keybindings
nnoremap <leader>ff :FZF<CR>

""" Test Settings
let test#strategy = "neovim"
let g:test#preserve_screen = 1

""" Test Keybindings
nnoremap <leader>tn :TestNearest<CR>
nnoremap <leader>tf :TestFile<CR>
nnoremap <leader>ts :TestSuite<CR>
nnoremap <leader>tl :TestLast<CR>
nnoremap <leader>tv :TestVisit<CR>

""" Window Navigation Keybindings
nnoremap <leader>wq :bd<Enter>
nnoremap <leader><S-q> :%bd<CR>:q<CR>
nnoremap <leader>w<S-l> :vertical resize +5<Enter>
nnoremap <leader>w<S-h> :vertical resize -5<Enter>
nnoremap <leader>w<S-j> :res +5<Enter>
nnoremap <leader>w<S-k> :res -5<Enter>
nnoremap <leader>wr<Right> :vertical resize +5<Enter>
nnoremap <leader>wr<Left> :vertical resize -5<Enter>
nnoremap <leader>wml <C-w>L 
nnoremap <leader>wm<Right> <C-w>L
nnoremap <leader>wh <C-w>h
nnoremap <leader>wj <C-w>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l
nnoremap <leader>wv :vsplit<CR><C-W>l
nnoremap <leader>wb :split<CR><C-W>j
nnoremap <leader>wk <C-w>k
nnoremap <leader>wl <C-w>l

""" Terminal Keybindings
tnoremap <Esc> <C-\><C-n>
nnoremap <leader>tt :split<CR><C-W>j:terminal<CR>a

""" Buffer Settings
function! GoToBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[GO TO BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = "b".buffer_number
  execute vim_command
endfunction

function! DeleteBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[DELETE BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = buffer_number."bd"
  execute vim_command
endfunction

function! DeleteAllBuffers()
    execute "%bd | e#"
endfunction

function! FindInBuffer()
  let curline = getline('.')
  call inputsave()
  let pattern = input('[FIND IN BUFFERS] Pattern : ')
  call inputrestore()
  let vim_command = "Ack ".pattern
  execute vim_command
endfunction

""" Buffer Keybindings
nnoremap <leader>bg :call GoToBuffer()<CR>
nnoremap <leader>bd :call DeleteBuffer()<CR>
nnoremap <leader>bD :call DeleteAllBuffers()<CR>
nnoremap <leader>bf :call FindInBuffer()<CR>
nnoremap <leader>bb :buffers<CR>:buffer<CR>
nnoremap <leader>be :e<CR>
nnoremap <leader>bl :bn<CR>
nnoremap <leader>bk :bn<CR>
nnoremap <leader>bh :bp<CR>
nnoremap <leader>bj :bp<CR>

""" Tab Keybindings (Views)
nnoremap <leader>vn :tabnew<CR>
nnoremap <leader>vl :tabnext<CR>
nnoremap <leader>vk :tabnext<CR>
nnoremap <leader>vh :tabprevious<CR>
nnoremap <leader>vj :tabprevious<CR>
nnoremap <leader>vd :tabclose<CR>

""" Python Keybindings
autocmd FileType python nnoremap <silent> <leader>lf :Black<CR>
autocmd FileType python nnoremap <silent> <leader>lp :Pydocstring<CR>
