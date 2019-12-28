call plug#begin()
""" UI
Plug 'mhinz/vim-startify'
Plug 'majutsushi/tagbar'

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
set number
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

function s:Keybinding_lsp(filetype)
    call g:keybinding#major.add(a:filetype, g:CommandKeybinding.new('d', 'Show Documentation', 'call LanguageClient#textDocument_hover()'))
    call g:keybinding#major.add(a:filetype, g:CommandKeybinding.new('g', 'GoTo Definition', 'call LanguageClient#textDocument_definition()'))
    call g:keybinding#major.add(a:filetype, g:CommandKeybinding.new('r', 'Raname', 'call LanguageClient#textDocument_rename()'))
    call g:keybinding#major.add(a:filetype, g:CommandKeybinding.new('h', 'Find References', 'call LanguageClient_textDocument_references()'))
    call g:keybinding#major.add(a:filetype, g:CommandKeybinding.new('c', 'Highlight References', 'call LanguageClient#textDocument_documentHighlight()'))
endfunction

""" FZF Keybindings
let g:keybinding#file = g:CategoryKeybinding.new('f', 'File')
call g:keybinding#file.add(g:CommandKeybinding.new('f', 'Fuzzy Find',  'FZF'))
call g:keybinding#root.add(g:keybinding#file)

""" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

""" Test Keybindings
let g:keybinding#test = g:CategoryKeybinding.new('t', 'Test')
call g:keybinding#test.add(g:CommandKeybinding.new('n', 'Test Nearest',  'TestNearest'))
call g:keybinding#test.add(g:CommandKeybinding.new('f','Test File', 'TestFile'))
call g:keybinding#test.add(g:CommandKeybinding.new('s', 'Test Suite', 'TestSuite'))
call g:keybinding#test.add(g:CommandKeybinding.new('l', 'Test Last', 'TestLast'))
call g:keybinding#test.add(g:CommandKeybinding.new('v', 'Test Visit', 'TestVisit'))
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

let g:terminal#id = 0
let g:terminal#name = 'myterminal'

function! OpenTerminal()
    let l:bufexists = bufexists(g:terminal#name)
    if l:bufexists == 1
        call win_gotoid(g:terminal#id)
        let l:terminal_id = win_getid()

        if l:terminal_id != g:terminal#id
            split
            wincmd J
            echo g:terminal#name
            execute 'buffer '.g:terminal#name
            let g:terminal#id = win_getid()
        endif
    else
        split
        wincmd j
        terminal
        setlocal norelativenumber
        setlocal nonumber
        execute 'file '.g:terminal#name
        let g:terminal#id = win_getid()
    endif
    startinsert
endfunction

""" Tagbar Settings
let g:tagbar_map_showproto='a'

""" Window Keybindings
let g:keybinding#window = g:CategoryKeybinding.new('w', 'Window')
call g:keybinding#window.add(g:CommandKeybinding.new('q', 'Quit Window', 'q'))
call g:keybinding#window.add(g:CommandKeybinding.new('L', 'Resize +Vertical', 'vertical resize +5'))
call g:keybinding#window.add(g:CommandKeybinding.new('H', 'Resize -Vertical', 'vertical resize -5'))
call g:keybinding#window.add(g:CommandKeybinding.new('J', 'Resize +Horizontal', 'res +5'))
call g:keybinding#window.add(g:CommandKeybinding.new('K', 'Resize -Horizontal', 'res -5'))
call g:keybinding#window.add(g:CommandKeybinding.new('h', 'Focus Left', 'wincmd h'))
call g:keybinding#window.add(g:CommandKeybinding.new('j', 'Focus Down',  'wincmd j'))
call g:keybinding#window.add(g:CommandKeybinding.new('k', 'Focus Top',  'wincmd k'))
call g:keybinding#window.add(g:CommandKeybinding.new('l', 'Focus Right',  'wincmd l'))
call g:keybinding#window.add(g:CommandKeybinding.new('v', 'Split Vertical',  'call VerticalSplit()'))
call g:keybinding#window.add(g:CommandKeybinding.new('b', 'Split Horizontal',  'call HorizontalSplit()'))
call g:keybinding#window.add(g:CommandKeybinding.new('t', 'Open Terminal',  'call OpenTerminal()'))
call g:keybinding#window.add(g:CommandKeybinding.new('e', 'Open Explorer',  'NERDTreeFocus'))
call g:keybinding#window.add(g:CommandKeybinding.new('c', 'Toggle CTags',  'TagbarToggle'))
call g:keybinding#root.add(g:keybinding#window)

""" Terminal Keybindings
tnoremap <Esc> <C-\><C-n>

""" Buffer Settings
function! GoToBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[GO TO BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = 'b'.buffer_number
  execute vim_command
endfunction

function! DeleteBuffer()
  let curline = getline('.')
  call inputsave()
  let buffer_number = input('[DELETE BUFFER] Buffer number: ')
  call inputrestore()
  let vim_command = buffer_number.'bd'
  execute vim_command
endfunction

function! DeleteAllBuffers()
    execute '%bd | e#'
endfunction

function! FindInBuffer()
  let curline = getline('.')
  call inputsave()
  let pattern = input('[FIND IN BUFFERS] Pattern : ')
  call inputrestore()
  let vim_command = 'Ack '.pattern
  execute vim_command
endfunction

""" Buffer Keybindings
let g:keybinding#buffer = g:CategoryKeybinding.new('b', 'Buffer')
call g:keybinding#buffer.add(g:CommandKeybinding.new('g', 'GoTo Buffer', 'call GoToBuffer()'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('d', 'Delete Buffer', 'call DeleteBuffer()'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('D', 'Delete All Buffers', 'call DeleteAllBuffers()'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('f', 'Find In Buffer', 'call FindInBuffer()'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('b', 'List All Buffers', 'buffers'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('e', 'New Buffer', 'e'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('l', 'Next Buffer', 'bn'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('k', 'Next Buffer', 'bn'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('h', 'Previous Buffer', 'bp'))
call g:keybinding#buffer.add(g:CommandKeybinding.new('j', 'Previous Buffer', 'bp'))
call g:keybinding#root.add(g:keybinding#buffer)

""" Tab Keybindings (Views)
let g:keybinding#tab = g:CategoryKeybinding.new('v', 'View')
call g:keybinding#tab.add(g:CommandKeybinding.new('n', 'Create View', 'tabnew'))
call g:keybinding#tab.add(g:CommandKeybinding.new('l', 'Next View', 'tabnext'))
call g:keybinding#tab.add(g:CommandKeybinding.new('k', 'Next View', 'tabnext'))
call g:keybinding#tab.add(g:CommandKeybinding.new('h', 'Previous View', 'tabprevious'))
call g:keybinding#tab.add(g:CommandKeybinding.new('j', 'Previous View', 'tabprevious'))
call g:keybinding#tab.add(g:CommandKeybinding.new('d', 'Close View', 'tabclose'))
call g:keybinding#root.add(g:keybinding#tab)

""" Python Settings
let g:neomake_python_enabled_makers = ['flake8', 'mypy']

call s:Keybinding_lsp('python')
call g:keybinding#major.add('python', g:CommandKeybinding.new('f', 'Format Document', 'Black'))
call g:keybinding#major.add('python', g:CommandKeybinding.new('p', 'Generate Pydocstring', 'Pydocstring'))
call g:keybinding#major.add('python', g:CommandKeybinding.new('e', 'Next Error', 'lnext'))
call g:keybinding#major.add('python', g:CommandKeybinding.new('E', 'Previous Error', 'lprev'))

""" LaTeX Settings
call s:Keybinding_lsp('tex')
call g:keybinding#major.add('tex', g:CommandKeybinding.new('e', 'Next Error', 'lnext'))
call g:keybinding#major.add('tex', g:CommandKeybinding.new('E', 'Previous Error', 'lprev'))


""" Javascript Settings
call s:Keybinding_lsp('javascript')
call g:keybinding#major.add('javascript', g:CommandKeybinding.new('e', 'Next Error', 'lnext'))
call g:keybinding#major.add('javascript', g:CommandKeybinding.new('E', 'Previous Error', 'lprev'))

let g:keybinding#show = 1
nnoremap <silent> <leader> :call g:keybinding#root.execute()<CR>
