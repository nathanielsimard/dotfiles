" Airline Settings
let g:airline_powerline_fonts = 1

" Theming
set background=dark
set termguicolors
let g:airline_theme='base16'
colorscheme base16-default-dark

" Basic Settings
set tabstop=4 shiftwidth=4 expandtab 
set number
set relativenumber
set nowrap
let mapleader = ' '
syntax on
set hidden

" NERDTree Settings
let NERDTreeShowHidden=1

" Linux helper
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

" Window Navigation Keybindings
function! HorizontalSplit()
    split
    wincmd j
endfunction

function! VerticalSplit()
    vsplit
    wincmd l
endfunction

function! RunWithTerminal(command)
    execute '!'.a:command
endfunction

" Terminal Settings
let g:floaterm_position='center'
autocmd TermOpen * setlocal norelativenumber
autocmd TermOpen * setlocal nonumber
tnoremap <Esc> <C-\><C-n>

" Buffer Settings
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

" VMenu Settings
nnoremap <silent> <Space> :call vmenu#show()<CR>

" VMenu Categories
let g:keybindings_refactor_run = vmenu#category('r', 'Refactor/Run')
let g:keybindings_goto = vmenu#category('g', 'GoTo')
let g:keybindings_error = vmenu#category('e', 'Error')
let g:keybindings_help = vmenu#category('h', 'Help')
let g:keybindings_documentation = vmenu#category('d', 'Documentation')
let g:keybindings_test = vmenu#category('t', 'Testing')
let g:keybindings_buffer = vmenu#category('b', 'Buffer')
let g:keybindings_window = vmenu#category('w', 'Window')
let g:keybindings_view = vmenu#category('v', 'View')
let g:keybindings_file = vmenu#category('f', 'File')

" File Keybindings
call vmenu#commands([
            \['f', 'Find Open',  'FZF'],
            \['x', 'Find Xdg Open',  'call g:linux_open.find()'],
            \['t', 'Focus Tree',  'NERDTreeFocus'],
            \['c', 'Close Tree',  'NERDTreeClose'],
            \['r', 'Refresh Tree',  'NERDTreeRefreshRoot'],
            \['n', 'New File',  'call NewFile()']
        \], {
            \'parent': g:keybindings_file
        \})

" Window Keybindings
call vmenu#commands([
            \['q', 'Quit Window', 'q'],
            \['L', 'Add Vertical Space', 'vertical resize +5'],
            \['H', 'Remove Vertical Space', 'vertical resize -5'],
            \['J', 'Add Horizontal Space', 'res +5'],
            \['K', 'Remove Horizontal Space', 'res -5'],
            \['h', 'Focus Left', 'wincmd h'],
            \['j', 'Focus Down',  'wincmd j'],
            \['k', 'Focus Top',  'wincmd k'],
            \['l', 'Focus Right',  'wincmd l'],
            \['v', 'Split Vertical',  'call VerticalSplit()'],
            \['b', 'Split Horizontal',  'call HorizontalSplit()']
        \], {
            \'parent': g:keybindings_window
        \})

" Buffer Keybindings
call vmenu#commands([
            \['g', 'GoTo Buffer', 'call GoToBuffer()'],
            \['d', 'Delete Buffer', 'call DeleteBuffer()'],
            \['D', 'Delete All Buffers', 'call DeleteAllBuffers()'],
            \['f', 'Find In Buffer', 'call FindInBuffer()'],
            \['b', 'List All Buffers', 'buffers'],
            \['s', 'Save Buffer', 'w'],
            \['S', 'Save All Buffers', 'wa'],
            \['l', 'Next Buffer', 'bn'],
            \['k', 'Next Buffer', 'bn'],
            \['h', 'Previous Buffer', 'bp'],
            \['j', 'Previous Buffer', 'bp']
        \], { 
            \'parent': g:keybindings_buffer
        \})

" Tab Keybindings (Views)
call vmenu#commands([
            \['n', 'Create View', 'tabnew'],
            \['l', 'Next View', 'tabnext'],
            \['k', 'Next View', 'tabnext'],
            \['h', 'Previous View', 'tabprevious'],
            \['j', 'Previous View', 'tabprevious'],
            \['d', 'Close View', 'tabclose']
        \], {
            \'parent': g:keybindings_view
        \})

" Simple Keybindings
call vmenu#commands([
            \['Q', 'Quit', 'qa'],
            \['s', 'Save File', 'w'],
            \['S', 'Save All Files', 'wa'],
            \["'", 'Terminal', 'FloatermToggle']
        \])
