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

""" Imports
source ~/.config/nvim/menu.vim

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
let g:neomake_javascript_enabled_makers = ['eslint']

""" Language Server Settings
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['python', '-m', 'pyls'],
    \ 'tex': ['~/.local/bin/tex-lsp'],
    \ 'javascript': ['javascript-typescript-stdio', '-l', '/tmp/javascript-typescript-stdio.log'],
    \ }
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0

""" FZF Keybindings
let g:keybinding#file = g:CategoryKeybinding.new("g:keybinding#file", "f", "File")
call g:keybinding#file.add(g:BasicKeybinding.new("f", "Fuzzy Find",  "FZF"))
call g:keybinding#root.add(g:keybinding#file)

""" Test Settings
let test#strategy = "neovim"
let g:test#preserve_screen = 1

""" Test Keybindings
let g:keybinding#test = g:CategoryKeybinding.new("g:keybinding#test", "t", "Test")
call g:keybinding#test.add(g:BasicKeybinding.new("n", "Test Nearest",  "TestNearest"))
call g:keybinding#test.add(g:BasicKeybinding.new("f","Test File", "TestFile"))
call g:keybinding#test.add(g:BasicKeybinding.new("s", "Test Suite", "TestSuite"))
call g:keybinding#test.add(g:BasicKeybinding.new("l", "Test Last", "TestLast"))
call g:keybinding#test.add(g:BasicKeybinding.new("v", "Test Visit", "TestVisit"))
call g:keybinding#root.add(g:keybinding#test)

""" Window Navigation Keybindings

function! HorizontalSplit()
    split
    wincmd j
endfunction

function! VerticalSplit()
    vsplit
    wincmd l
endfunction

function! OpenTerminal()
    split
    wincmd j
    terminal
    startinsert
endfunction

""" Window Keybindings
let g:keybinding#window = g:CategoryKeybinding.new("g:keybinding#window", "w", "Window")
call g:keybinding#window.add(g:BasicKeybinding.new("q", "Quit Window", "q"))
call g:keybinding#window.add(g:BasicKeybinding.new("L", "Resize +Vertical", "vertical resize +5"))
call g:keybinding#window.add(g:BasicKeybinding.new("H", "Resize -Vertical", "vertical resize -5"))
call g:keybinding#window.add(g:BasicKeybinding.new("J", "Resize +Horizontal", "res +5"))
call g:keybinding#window.add(g:BasicKeybinding.new("K", "Resize -Horizontal", "res -5"))
call g:keybinding#window.add(g:BasicKeybinding.new("h", "Focus Left", "wincmd h"))
call g:keybinding#window.add(g:BasicKeybinding.new("j", "Focus Down",  "wincmd j"))
call g:keybinding#window.add(g:BasicKeybinding.new("k", "Focus Top",  "wincmd k"))
call g:keybinding#window.add(g:BasicKeybinding.new("l", "Focus Right",  "wincmd l"))
call g:keybinding#window.add(g:BasicKeybinding.new("v", "Split Vertical",  "call VerticalSplit()"))
call g:keybinding#window.add(g:BasicKeybinding.new("b", "Split Horizontal",  "call HorizontalSplit()"))
call g:keybinding#window.add(g:BasicKeybinding.new("t", "Open Terminal",  "call OpenTerminal()"))
call g:keybinding#window.add(g:BasicKeybinding.new("e", "Open Explorer",  "NERDTreeFocus"))
call g:keybinding#root.add(g:keybinding#window)

""" Terminal Keybindings
tnoremap <Esc> <C-\><C-n>

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
let g:keybinding#buffer = g:CategoryKeybinding.new("g:keybinding#buffer", "b", "Buffer")
call g:keybinding#buffer.add(g:BasicKeybinding.new("g", "GoTo Buffer", "call GoToBuffer()"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("d", "Delete Buffer", "call DeleteBuffer()"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("D", "Delete All Buffers", "call DeleteAllBuffers()"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("f", "Find In Buffer", "call FindInBuffer()"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("b", "List All Buffers", "buffers"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("e", "New Buffer", "e"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("l", "Next Buffer", "bn"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("k", "Next Buffer", "bn"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("h", "Previous Buffer", "bp"))
call g:keybinding#buffer.add(g:BasicKeybinding.new("j", "Previous Buffer", "bp"))
call g:keybinding#root.add(g:keybinding#buffer)

""" Tab Keybindings (Views)
let g:keybinding#tab = g:CategoryKeybinding.new("g:keybinding#tab", "v", "View")
call g:keybinding#tab.add(g:BasicKeybinding.new("n", "Create View", "tabnew"))
call g:keybinding#tab.add(g:BasicKeybinding.new("l", "Next View", "tabnext"))
call g:keybinding#tab.add(g:BasicKeybinding.new("k", "Next View", "tabnext"))
call g:keybinding#tab.add(g:BasicKeybinding.new("h", "Previous View", "tabprevious"))
call g:keybinding#tab.add(g:BasicKeybinding.new("j", "Previous View", "tabprevious"))
call g:keybinding#tab.add(g:BasicKeybinding.new("d", "Close View", "tabclose"))
call g:keybinding#root.add(g:keybinding#tab)

""" Python Settings
let g:neomake_python_enabled_makers = ['flake8', 'mypy']

let g:keybinding#python = g:CategoryKeybinding.new("g:keybinding#python", "l", "Python")
call g:keybinding#python.add(g:BasicKeybinding.new("f", "Format Document", "Black"))
call g:keybinding#python.add(g:BasicKeybinding.new("p", "Generate Pydocstring", "Pydocstring"))
call g:keybinding#python.add(g:BasicKeybinding.new("d", "Show Documentation", "call LanguageClient#textDocument_hover()"))
call g:keybinding#python.add(g:BasicKeybinding.new("g", "GoTo Definition", "call LanguageClient#textDocument_definition()"))
call g:keybinding#python.add(g:BasicKeybinding.new("r", "Raname", "call LanguageClient#textDocument_rename()"))
call g:keybinding#python.add(g:BasicKeybinding.new("h", "Find References", "call LanguageClient_textDocument_references()"))
call g:keybinding#python.add(g:BasicKeybinding.new("c", "Highlight References", "call LanguageClient#textDocument_documentHighlight()"))
call g:keybinding#python.add(g:BasicKeybinding.new("e", "Next Error", "lnext"))
call g:keybinding#python.add(g:BasicKeybinding.new("E", "Previous Error", "lprev"))
call g:keybinding#major.add("python", g:keybinding#python)

""" LaTeX Settings
let g:keybinding#tex = g:CategoryKeybinding.new("g:keybinding#tex", "l", "LaTeX")
call g:keybinding#tex.add(g:BasicKeybinding.new("d", "Show Documentation", "call LanguageClient#textDocument_hover()"))
call g:keybinding#tex.add(g:BasicKeybinding.new("g", "GoTo Definition", "call LanguageClient#textDocument_definition()"))
call g:keybinding#tex.add(g:BasicKeybinding.new("r", "Raname", "call LanguageClient#textDocument_rename()"))
call g:keybinding#tex.add(g:BasicKeybinding.new("h", "Find References", "call LanguageClient_textDocument_references()"))
call g:keybinding#tex.add(g:BasicKeybinding.new("c", "Highlight References", "call LanguageClient#textDocument_documentHighlight()"))
call g:keybinding#tex.add(g:BasicKeybinding.new("e", "Next Error", "lnext"))
call g:keybinding#tex.add(g:BasicKeybinding.new("E", "Previous Error", "lprev"))
call g:keybinding#major.add("LaTeX", g:keybinding#tex)

""" Javascript Settings
let g:keybinding#js = g:CategoryKeybinding.new("g:keybinding#js", "l", "Javascript")
call g:keybinding#js.add(g:BasicKeybinding.new("d", "Show Documentation", "call LanguageClient#textDocument_hover()"))
call g:keybinding#js.add(g:BasicKeybinding.new("g", "GoTo Definition", "call LanguageClient#textDocument_definition()"))
call g:keybinding#js.add(g:BasicKeybinding.new("r", "Raname", "call LanguageClient#textDocument_rename()"))
call g:keybinding#js.add(g:BasicKeybinding.new("h", "Find References", "call LanguageClient_textDocument_references()"))
call g:keybinding#js.add(g:BasicKeybinding.new("c", "Highlight References", "call LanguageClient#textDocument_documentHighlight()"))
call g:keybinding#js.add(g:BasicKeybinding.new("e", "Next Error", "lnext"))
call g:keybinding#js.add(g:BasicKeybinding.new("E", "Previous Error", "lprev"))
call g:keybinding#major.add("javascript", g:keybinding#js)

call ResetKeybindings()
