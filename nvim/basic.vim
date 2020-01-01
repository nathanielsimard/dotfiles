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

""" Keybindings Settings
let g:menu = vmenu#new()
let g:keybindings_root = vmenu#keybinding#category#new('no important', 'Keybinding Menu')
nnoremap <silent> <Space> :call g:keybindings_root.execute(g:menu)<CR>

" File Type Keybindings
let g:keybindings_refactor = vmenu#keybinding#filetype#new('r', 'Refactor')
let g:keybindings_goto = vmenu#keybinding#filetype#new('g', 'GoTo')
let g:keybindings_error = vmenu#keybinding#filetype#new('e', 'Error')
let g:keybindings_help = vmenu#keybinding#filetype#new('h', 'Help')
let g:keybindings_documentation = vmenu#keybinding#filetype#new('d', 'Documentation')
let g:keybindings_test = vmenu#keybinding#filetype#new('t', 'Testing')

call g:keybindings_root.add(g:keybindings_refactor)
call g:keybindings_root.add(g:keybindings_goto)
call g:keybindings_root.add(g:keybindings_error)
call g:keybindings_root.add(g:keybindings_help)
call g:keybindings_root.add(g:keybindings_documentation)
call g:keybindings_root.add(g:keybindings_test)

" Category Keybindings
let g:keybindings_buffer = vmenu#keybinding#category#new('b', 'Buffer')
let g:keybindings_window = vmenu#keybinding#category#new('w', 'Window')
let g:keybindings_view = vmenu#keybinding#category#new('v', 'View')
let g:keybindings_file = vmenu#keybinding#category#new('f', 'File')

call g:keybindings_root.add(g:keybindings_buffer)
call g:keybindings_root.add(g:keybindings_window)
call g:keybindings_root.add(g:keybindings_view)
call g:keybindings_root.add(g:keybindings_file)


let g:linux_open={}
function g:linux_open.open(file)
    call jobstart('xdg-open '.a:file)
endfunction

function! g:linux_open.find()
    call fzf#run({'sink': g:linux_open.open})
endfunction

function! NewFile()
  let curline = getline('.')
  call inputsave()
  let l:name = input('[New File] Name : ')
  call inputrestore()
  execute 'e '.l:name
  w
  NERDTreeRefreshRoot
endfunction


""" File Keybindings
call g:keybindings_file.add(vmenu#keybinding#command#new('f', 'Find Open',  'FZF'))
call g:keybindings_file.add(vmenu#keybinding#command#new('x', 'Find Xdg Open',  'call g:linux_open.find()'))
call g:keybindings_file.add(vmenu#keybinding#command#new('t', 'Focus Tree',  'NERDTreeFocus'))
call g:keybindings_file.add(vmenu#keybinding#command#new('c', 'Close Tree',  'NERDTreeClose'))
call g:keybindings_file.add(vmenu#keybinding#command#new('r', 'Refresh Tree',  'NERDTreeRefreshRoot'))
call g:keybindings_file.add(vmenu#keybinding#command#new('n', 'New File',  'call NewFile()'))

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
call g:keybindings_window.add(vmenu#keybinding#command#new('q', 'Quit Window', 'q'))
call g:keybindings_window.add(vmenu#keybinding#command#new('L', 'Add Vertical Space', 'vertical resize +5'))
call g:keybindings_window.add(vmenu#keybinding#command#new('H', 'Remove Vertical Space', 'vertical resize -5'))
call g:keybindings_window.add(vmenu#keybinding#command#new('J', 'Add Horizontal Space', 'res +5'))
call g:keybindings_window.add(vmenu#keybinding#command#new('K', 'Remove Horizontal Space', 'res -5'))
call g:keybindings_window.add(vmenu#keybinding#command#new('h', 'Focus Left', 'wincmd h'))
call g:keybindings_window.add(vmenu#keybinding#command#new('j', 'Focus Down',  'wincmd j'))
call g:keybindings_window.add(vmenu#keybinding#command#new('k', 'Focus Top',  'wincmd k'))
call g:keybindings_window.add(vmenu#keybinding#command#new('l', 'Focus Right',  'wincmd l'))
call g:keybindings_window.add(vmenu#keybinding#command#new('v', 'Split Vertical',  'call VerticalSplit()'))
call g:keybindings_window.add(vmenu#keybinding#command#new('b', 'Split Horizontal',  'call HorizontalSplit()'))

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
call g:keybindings_buffer.add(vmenu#keybinding#command#new('g', 'GoTo Buffer', 'call GoToBuffer()'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('d', 'Delete Buffer', 'call DeleteBuffer()'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('D', 'Delete All Buffers', 'call DeleteAllBuffers()'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('f', 'Find In Buffer', 'call FindInBuffer()'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('b', 'List All Buffers', 'buffers'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('e', 'New Buffer', 'e'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('l', 'Next Buffer', 'bn'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('k', 'Next Buffer', 'bn'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('h', 'Previous Buffer', 'bp'))
call g:keybindings_buffer.add(vmenu#keybinding#command#new('j', 'Previous Buffer', 'bp'))

""" Tab Keybindings (Views)
call g:keybindings_view.add(vmenu#keybinding#command#new('n', 'Create View', 'tabnew'))
call g:keybindings_view.add(vmenu#keybinding#command#new('l', 'Next View', 'tabnext'))
call g:keybindings_view.add(vmenu#keybinding#command#new('k', 'Next View', 'tabnext'))
call g:keybindings_view.add(vmenu#keybinding#command#new('h', 'Previous View', 'tabprevious'))
call g:keybindings_view.add(vmenu#keybinding#command#new('j', 'Previous View', 'tabprevious'))
call g:keybindings_view.add(vmenu#keybinding#command#new('d', 'Close View', 'tabclose'))

""" Simple Keybindings
call g:keybindings_root.add(vmenu#keybinding#command#new('Q', 'Quit', 'qa'))
call g:keybindings_root.add(vmenu#keybinding#command#new("'", 'Terminal', 'call OpenTerminal()'))

