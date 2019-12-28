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

" Imports
source ~/.config/nvim/keybinding.vim

" Root Keybindings
let g:keybindings_root = g:CategoryKeybinding.new('no important', 'Keybinding Menu')

" File Type Keybindings
let s:keybindings_refactor = g:FileTypeKeybinding.new('r', 'Refactor')
let s:keybindings_goto = g:FileTypeKeybinding.new('g', 'Go To')
let s:keybindings_error = g:FileTypeKeybinding.new('e', 'Error')
let s:keybindings_help = g:FileTypeKeybinding.new('h', 'Help')
let s:keybindings_test = g:FileTypeKeybinding.new('t', 'Testing')
let s:keybindings_generate = g:FileTypeKeybinding.new('c', 'Code Generation')

call g:keybindings_root.add(s:keybindings_refactor)
call g:keybindings_root.add(s:keybindings_goto)
call g:keybindings_root.add(s:keybindings_error)
call g:keybindings_root.add(s:keybindings_help)
call g:keybindings_root.add(s:keybindings_test)
call g:keybindings_root.add(s:keybindings_generate)

" Category Keybindings
let s:keybindings_buffer = g:CategoryKeybinding.new('b', 'Buffer')
let s:keybindings_window = g:CategoryKeybinding.new('w', 'Window')
let s:keybindings_view = g:CategoryKeybinding.new('v', 'View')
let s:keybindings_file = g:CategoryKeybinding.new('f', 'File')

call g:keybindings_root.add(s:keybindings_buffer)
call g:keybindings_root.add(s:keybindings_window)
call g:keybindings_root.add(s:keybindings_view)
call g:keybindings_root.add(s:keybindings_file)

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
call s:keybindings_error.add(g:CommandKeybinding.new('e', 'Next Error', 'lnext'))
call s:keybindings_error.add(g:CommandKeybinding.new('E', 'Previous Error', 'lprev'))

""" Language Server Settings
set hidden
let g:LanguageClient_serverCommands = {
    \ 'python': ['python', '-m', 'pyls'],
    \ 'tex': ['~/.local/bin/tex-lsp'],
    \ 'javascript': ['javascript-typescript-stdio'],
    \ }
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0
call LanguageClient#setLoggingLevel('ERROR')

function s:Keybinding_lsp(filetype)
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('d', 'Show Documentation', 'call LanguageClient#textDocument_hover()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('l', 'LSP Options', 'call LanguageClient_contextMenu()()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('s', 'Document Symbol', 'call LanguageClient#textDocument_documentSymbol()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'List References', 'call LanguageClient#textDocument_references()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('a', 'Code Action', 'call LanguageClient#textDocument_codeAction()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('c', 'Code Action', 'call LanguageClient#textDocument_completion()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'Highlight References', 'call LanguageClient#textDocument_documentHighlight()'))
    call s:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('e', 'Explain Error', 'call LanguageClient#explainErrorAtPoint()'))

    call s:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('d', 'Definition', 'call LanguageClient#textDocument_definition()'))
    call s:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('i', 'Implementation', 'call LanguageClient#textDocument_implementation()'))
    call s:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'References', 'call LanguageClient#textDocument_references()'))

    call s:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'Raname', 'call LanguageClient#textDocument_rename()'))
    call s:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('f', 'Format', 'call LanguageClient#textDocument_formatting()'))
    call s:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('F', 'Range Format', 'call LanguageClient#textDocument_rangeFormatting()'))

    call s:keybindings_error.add_filetype(a:filetype, g:CommandKeybinding.new('l', 'List', 'call LanguageClient#setDiagnosticsList()'))
endfunction

""" FZF Keybindings
call s:keybindings_file.add(g:CommandKeybinding.new('f', 'Find',  'FZF'))
call s:keybindings_file.add(g:CommandKeybinding.new('t', 'Focus Tree',  'NERDTreeFocus'))
call s:keybindings_file.add(g:CommandKeybinding.new('c', 'Close Tree',  'NERDTreeClose'))
call s:keybindings_file.add(g:CommandKeybinding.new('r', 'Refresh Tree',  'NERDTreeRefreshRoot'))

""" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

""" Test Keybindings
call s:keybindings_test.add(g:CommandKeybinding.new('n', 'Test Nearest',  'TestNearest'))
call s:keybindings_test.add(g:CommandKeybinding.new('f','Test File', 'TestFile'))
call s:keybindings_test.add(g:CommandKeybinding.new('s', 'Test Suite', 'TestSuite'))
call s:keybindings_test.add(g:CommandKeybinding.new('l', 'Test Last', 'TestLast'))
call s:keybindings_test.add(g:CommandKeybinding.new('v', 'Test Visit', 'TestVisit'))

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
call s:keybindings_window.add(g:CommandKeybinding.new('q', 'Quit Window', 'q'))
call s:keybindings_window.add(g:CommandKeybinding.new('L', 'Add Vertical Space', 'vertical resize +5'))
call s:keybindings_window.add(g:CommandKeybinding.new('H', 'Remove Vertical Space', 'vertical resize -5'))
call s:keybindings_window.add(g:CommandKeybinding.new('J', 'Add Horizontal Space', 'res +5'))
call s:keybindings_window.add(g:CommandKeybinding.new('K', 'Remove Horizontal Space', 'res -5'))
call s:keybindings_window.add(g:CommandKeybinding.new('h', 'Focus Left', 'wincmd h'))
call s:keybindings_window.add(g:CommandKeybinding.new('j', 'Focus Down',  'wincmd j'))
call s:keybindings_window.add(g:CommandKeybinding.new('k', 'Focus Top',  'wincmd k'))
call s:keybindings_window.add(g:CommandKeybinding.new('l', 'Focus Right',  'wincmd l'))
call s:keybindings_window.add(g:CommandKeybinding.new('v', 'Split Vertical',  'call VerticalSplit()'))
call s:keybindings_window.add(g:CommandKeybinding.new('b', 'Split Horizontal',  'call HorizontalSplit()'))

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
call s:keybindings_buffer.add(g:CommandKeybinding.new('g', 'GoTo Buffer', 'call GoToBuffer()'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('d', 'Delete Buffer', 'call DeleteBuffer()'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('D', 'Delete All Buffers', 'call DeleteAllBuffers()'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('f', 'Find In Buffer', 'call FindInBuffer()'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('b', 'List All Buffers', 'buffers'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('e', 'New Buffer', 'e'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('l', 'Next Buffer', 'bn'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('k', 'Next Buffer', 'bn'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('h', 'Previous Buffer', 'bp'))
call s:keybindings_buffer.add(g:CommandKeybinding.new('j', 'Previous Buffer', 'bp'))

""" Tab Keybindings (Views)
call s:keybindings_view.add(g:CommandKeybinding.new('n', 'Create View', 'tabnew'))
call s:keybindings_view.add(g:CommandKeybinding.new('l', 'Next View', 'tabnext'))
call s:keybindings_view.add(g:CommandKeybinding.new('k', 'Next View', 'tabnext'))
call s:keybindings_view.add(g:CommandKeybinding.new('h', 'Previous View', 'tabprevious'))
call s:keybindings_view.add(g:CommandKeybinding.new('j', 'Previous View', 'tabprevious'))
call s:keybindings_view.add(g:CommandKeybinding.new('d', 'Close View', 'tabclose'))

""" Simple Keybindings
call g:keybindings_root.add(g:CommandKeybinding.new('Q', 'Quit', 'qa'))
call g:keybindings_root.add(g:CommandKeybinding.new("'", 'Terminal', 'call OpenTerminal()'))
call g:keybindings_root.add(g:CommandKeybinding.new('c', 'Toggle CTags',  'TagbarToggle'))

""" Python Settings
let g:neomake_python_enabled_makers = ['flake8', 'mypy']

call s:Keybinding_lsp('python')
call s:keybindings_refactor.add_filetype('python', g:CommandKeybinding.new('f', 'Format Document', 'Black'))
call s:keybindings_generate.add_filetype('python', g:CommandKeybinding.new('p', 'Pydocstring', 'Pydocstring'))

""" LaTeX Settings
call s:Keybinding_lsp('tex')

""" Javascript Settings
call s:Keybinding_lsp('javascript')

nnoremap <silent> <leader> :call g:keybindings_root.execute()<CR>
