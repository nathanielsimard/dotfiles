" Theming
set background=dark
set termguicolors
set noshowmode

"augroup Background
"    autocmd ColorScheme * hi Normal ctermbg=none guibg=none
"    autocmd ColorScheme myspecialcolors hi Normal ctermbg=red guibg=red
"augroup END

let g:airline_theme='base16'
colorscheme base16-default-dark

" Basic Settings
set tabstop=4 shiftwidth=4 expandtab 
set clipboard+=unnamedplus
set number
set relativenumber
set nowrap
let mapleader = ' '
syntax on
set hidden
set scrolloff=10
set mouse+=a

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

let g:previous_buffer = -1
let g:next_buffer = bufnr('%')
function s:UpdateBuffers()
    let s:name = bufname('%')
    let s:num = bufnr('%')

    if s:name !=# '' &&
                \s:name !=# 'vmenu' &&
                \s:name[0:4] !=# 'term:' &&
                \s:num !=# g:next_buffer &&
                \s:name[:3] !=# 'NERD'
        let g:previous_buffer = g:next_buffer
        let g:next_buffer = s:num
    endif
endfunction

function! PreviousBuffer()
    execute 'b'.g:previous_buffer
endfunction

augroup PreBuf
    autocmd BufEnter * call s:UpdateBuffers()
augroup END

" VMenu Settings
nnoremap <silent> <Space> :call vmenu#show()<CR>

" VMenu Categories
let g:keybindings_refactor_run = vmenu#category('r', 'Refactor/Run')
let g:keybindings_git = vmenu#category('g', 'Git')
let g:keybindings_error = vmenu#category('e', 'Error')
let g:keybindings_interactive = vmenu#category('i', 'Interactive')
let g:keybindings_spelling = vmenu#category('s', 'Spelling')
let g:keybindings_help = vmenu#category('h', 'Help')
let g:keybindings_documentation = vmenu#category('d', 'Documentation')
let g:keybindings_tab = vmenu#category('t', 'Tab')
let g:keybindings_jumps_jobs = vmenu#category('j', 'Jumps/Jobs')
let g:keybindings_buffer = vmenu#category('b', 'Buffer')
let g:keybindings_window = vmenu#category('w', 'Window')
let g:keybindings_ui = vmenu#category('u', 'Ui/Toggle')
let g:keybindings_file = vmenu#category('f', 'File/Find')

" File Keybindings
call vmenu#commands([
            \['f', 'Find Files',  'Files'],
            \['l', 'Find Lines',  'BLines'],
            \['x', 'Find Xdg Open',  'call g:linux_open.find()'],
            \['t', 'Focus Tree',  'NERDTreeFocus'],
            \['c', 'Close Tree',  'NERDTreeClose'],
            \['r', 'Refresh Tree',  'NERDTreeRefreshRoot'],
            \['n', 'New File',  'call NewFile()'],
        \], {
            \'parent': g:keybindings_file
        \})

function! basic#git_commit()
    let curline = getline('.')
    call inputsave()
    let message = input('[Git Commit Message]: ')
    call inputrestore()
    call terminal#run_command('git commit -m "'.message.'"')
endfunction

function! basic#git_branch()
    let curline = getline('.')
    call inputsave()
    let name = input('[Git Branch Name]: ')
    call inputrestore()
    call terminal#run_command('git checkout -b "'.name.'"')
    call terminal#run_command('git push -u origin "'.name.'"')
endfunction

function! basic#git_sync()
    call terminal#run_command('git add --all')
    call basic#git_commit()
    call terminal#run_command('git push')
endfunction

let g:airline#extensions#branch#enabled = 1

" Git Keybindings
call vmenu#commands([
            \['s', 'Status',  'GFiles?'],
            \['m', 'Checkout master',  'call terminal#run_command("git checkout master")'],
            \['l', 'List Buffer Commits',  'BCommits'],
            \['p', 'Pull',  'call terminal#run_command("git pull")'],
            \['b', 'Show Branches',  'call terminal#run_command("git branch")'],
            \['S', 'Save & Sync Everything',  'call basic#git_sync()'],
            \['A', 'Add All',  'call terminal#run_command("git add --all")'],
            \['C', 'Create Commits',  'call basic#git_commit()'],
            \['P', 'Push Branch',  'call terminal#run_command("git push")'],
            \['B', 'Create Branch',  'call basic#git_branch()'],
        \], {
            \'parent': g:keybindings_git
        \})

" Window Keybindings
call vmenu#commands([
            \['q', 'Quit Window', 'q'],
            \['L', 'Add Vertical Space', 'vertical resize +5'],
            \['H', 'Remove Vertical Space', 'vertical resize -5'],
            \['J', 'Add Horizontal Space', 'res +5'],
            \['K', 'Remove Horizontal Space', 'res -5'],
            \['p', 'Previous Window', 'call PreviousBuffer()'],
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
            \['d', 'Delete Buffer Num', 'call DeleteBuffer()'],
            \['q', 'Delete Current Buffer', 'bd'],
            \['D', 'Delete All Buffers', 'call DeleteAllBuffers()'],
            \['f', 'Find In Buffer', 'call FindInBuffer()'],
            \['b', 'List All Buffers', 'Buffers'],
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
            \['n', 'New Tab', 'tabnew'],
            \['l', 'Next View', 'tabnext'],
            \['k', 'Next View', 'tabnext'],
            \['h', 'Previous View', 'tabprevious'],
            \['j', 'Previous View', 'tabprevious'],
            \['d', 'Close View', 'tabclose']
        \], {
            \'parent': g:keybindings_tab
        \})

" Ui/Toggle Keybindings
call vmenu#commands([
            \['t', 'Tree', 'NERDTreeToggle'],
        \], {
            \'parent': keybindings_ui
        \})

" Simple Keybindings
call vmenu#commands([
            \['Q', 'Quit', 'qa'],
            \['S', 'Save All Files', 'wa'],
        \])
