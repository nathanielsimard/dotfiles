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

""" Basic Settings
set tabstop=4 shiftwidth=4 expandtab 
set number
set relativenumber
set nowrap
let mapleader = ' '
syntax on
set hidden

let g:linux_open={}
function g:linux_open.open(file)
    call jobstart('xdg-open '.a:file)
endfunction

function! g:linux_open.find()
    call fzf#run({'sink': g:linux_open.open})
endfunction

""" File Keybindings
call g:keybindings_file.add(g:CommandKeybinding.new('f', 'Find Open',  'FZF'))
call g:keybindings_file.add(g:CommandKeybinding.new('x', 'Find Xdg Open',  'call g:linux_open.find()'))
call g:keybindings_file.add(g:CommandKeybinding.new('t', 'Focus Tree',  'NERDTreeFocus'))
call g:keybindings_file.add(g:CommandKeybinding.new('c', 'Close Tree',  'NERDTreeClose'))
call g:keybindings_file.add(g:CommandKeybinding.new('r', 'Refresh Tree',  'NERDTreeRefreshRoot'))

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

""" Window Keybindings
call g:keybindings_window.add(g:CommandKeybinding.new('q', 'Quit Window', 'q'))
call g:keybindings_window.add(g:CommandKeybinding.new('L', 'Add Vertical Space', 'vertical resize +5'))
call g:keybindings_window.add(g:CommandKeybinding.new('H', 'Remove Vertical Space', 'vertical resize -5'))
call g:keybindings_window.add(g:CommandKeybinding.new('J', 'Add Horizontal Space', 'res +5'))
call g:keybindings_window.add(g:CommandKeybinding.new('K', 'Remove Horizontal Space', 'res -5'))
call g:keybindings_window.add(g:CommandKeybinding.new('h', 'Focus Left', 'wincmd h'))
call g:keybindings_window.add(g:CommandKeybinding.new('j', 'Focus Down',  'wincmd j'))
call g:keybindings_window.add(g:CommandKeybinding.new('k', 'Focus Top',  'wincmd k'))
call g:keybindings_window.add(g:CommandKeybinding.new('l', 'Focus Right',  'wincmd l'))
call g:keybindings_window.add(g:CommandKeybinding.new('v', 'Split Vertical',  'call VerticalSplit()'))
call g:keybindings_window.add(g:CommandKeybinding.new('b', 'Split Horizontal',  'call HorizontalSplit()'))

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
call g:keybindings_buffer.add(g:CommandKeybinding.new('g', 'GoTo Buffer', 'call GoToBuffer()'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('d', 'Delete Buffer', 'call DeleteBuffer()'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('D', 'Delete All Buffers', 'call DeleteAllBuffers()'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('f', 'Find In Buffer', 'call FindInBuffer()'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('b', 'List All Buffers', 'buffers'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('e', 'New Buffer', 'e'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('l', 'Next Buffer', 'bn'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('k', 'Next Buffer', 'bn'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('h', 'Previous Buffer', 'bp'))
call g:keybindings_buffer.add(g:CommandKeybinding.new('j', 'Previous Buffer', 'bp'))

""" Tab Keybindings (Views)
call g:keybindings_view.add(g:CommandKeybinding.new('n', 'Create View', 'tabnew'))
call g:keybindings_view.add(g:CommandKeybinding.new('l', 'Next View', 'tabnext'))
call g:keybindings_view.add(g:CommandKeybinding.new('k', 'Next View', 'tabnext'))
call g:keybindings_view.add(g:CommandKeybinding.new('h', 'Previous View', 'tabprevious'))
call g:keybindings_view.add(g:CommandKeybinding.new('j', 'Previous View', 'tabprevious'))
call g:keybindings_view.add(g:CommandKeybinding.new('d', 'Close View', 'tabclose'))

""" Simple Keybindings
call g:keybindings_root.add(g:CommandKeybinding.new('Q', 'Quit', 'qa'))
call g:keybindings_root.add(g:CommandKeybinding.new("'", 'Terminal', 'call OpenTerminal()'))

