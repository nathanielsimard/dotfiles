" Set Host Prog
let g:python3_host_prog = '~/pythonenv/neovim/bin/python'

" Tree setup
lua << EOF
require'nvim-tree'.setup{
    view = {
        width = 30,
        side = "left",
    },
    diagnostics = {
        enable = true,
    },
    git = {
        ignore = false,
    },
}
EOF

" Indent Guide
let g:indent_blankline_char = '┊'
let g:indent_blankline_show_first_indent_level = v:false
lua vim.g.indentLine_bufNameExclude = { "term:.*" }

" Vim Startify
lua << EOF
require("project_nvim").setup{
    patterns = {
        ".git", 
        "_darcs",
        ".hg",
        ".bzr",
        ".svn",
        "Makefile",
        "package.json",
        "requirements.txt",
        "pyproject.toml",
        "Cargo.toml",
    },
}
EOF

let g:startify_change_to_dir=1
let g:startify_change_cmd = 'cd'

function! s:projectDirectories()
    let l:files = systemlist('cat ~/.projectdirs')
    return map(l:files, "{'line': v:val, 'path': v:val}")
endfunction

let g:startify_lists = [
          \ { 'type': function('s:projectDirectories'), 'header': ['   Project'] },
          \ { 'type': 'files',                          'header': ['   MRU']            },
          \ { 'type': 'dir',                            'header': ['   MRU '. getcwd()] },
          \ { 'type': 'sessions',                       'header': ['   Sessions']       },
          \ { 'type': 'bookmarks',                      'header': ['   Bookmarks']      },
          \ { 'type': 'commands',                       'header': ['   Commands']       },
          \]

" Theming
set termguicolors
set noshowmode
set encoding=UTF-8

function! NativeBackground()
    augroup Background
        autocmd!
        autocmd ColorScheme * hi Normal ctermbg=none guibg=#181818
        " autocmd ColorScheme * hi Normal ctermbg=none guibg=none
    augroup END
endfunction

let g:gruvbox_italic = 1
let g:gruvbox_bold = 1
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_contrast_light = 'medium'

let g:colorscheme_dark='gruvbox'
let g:colorscheme_light='base16-github'
let g:colorscheme_current=g:colorscheme_dark

let g:custom_color_red='#CC241D'
let g:custom_color_yellow='#FABD2F'
let g:custom_color_white='#D3D3D3'
let g:custom_color_backgound_dark='#2D2D2D'
let g:custom_color_backgound_white='#F5F5F5'

function! s:highlight(group, background, forground)
    execute "autocmd ColorScheme * hi ".a:group." guibg=".a:background." guifg=".a:forground
endfunction

function! s:highlight_background(group, background)
    execute "autocmd ColorScheme * hi ".a:group." guibg=".a:background
endfunction

function! WhiteColor()
    augroup Background
        autocmd!
        autocmd ColorScheme * hi Normal guibg=#D0D0D0
    augroup END
    augroup ModifiedColor
        autocmd!
        call s:highlight_background('VertSplit', g:custom_color_backgound_white)
        call s:highlight_background('LineNr', g:custom_color_backgound_white)
        call s:highlight_background('SignColumn', g:custom_color_backgound_white)
        call s:highlight_background('CursorColumn', g:custom_color_backgound_white)
        call s:highlight_background('CursorLine', g:custom_color_backgound_white)
        call s:highlight_background('ColorColumn', g:custom_color_backgound_white)
        call s:highlight_background('QuickFixLine', g:custom_color_backgound_white)
        call s:highlight('CursorLineNr', g:custom_color_backgound_white, '#333333')
        " Legacy
        call s:highlight('LspDiagnosticsSignError', g:custom_color_backgound_white, g:custom_color_red)
        call s:highlight('LspDiagnosticsSignWarning', g:custom_color_backgound_white, g:custom_color_yellow)
        " New
        call s:highlight('DiagnosticSignError', g:custom_color_backgound_white, g:custom_color_red)
        call s:highlight('DiagnosticSignWarning', g:custom_color_backgound_white, g:custom_color_yellow)
    augroup END
endfunction

function! BlackColor()
    call NativeBackground()
    augroup ModifiedColor
        autocmd!
        call s:highlight_background('VertSplit', g:custom_color_backgound_dark)
        call s:highlight_background('LineNr', g:custom_color_backgound_dark)
        call s:highlight_background('CursorLineNr', g:custom_color_backgound_dark)
        call s:highlight_background('SignColumn', g:custom_color_backgound_dark)
        call s:highlight_background('CursorColumn', g:custom_color_backgound_dark)
        call s:highlight_background('CursorLine', g:custom_color_backgound_dark)
        call s:highlight_background('ColorColumn', g:custom_color_backgound_dark)
        call s:highlight_background('QuickFixLine', g:custom_color_backgound_dark)
        " Legacy
        call s:highlight('LspDiagnosticsSignError', '#2D2D2D', g:custom_color_red)
        call s:highlight('LspDiagnosticsSignWarning', '#2D2D2D', g:custom_color_yellow)
        call s:highlight('LspDiagnosticsSignInformation', '#2D2D2D', g:custom_color_white)
        call s:highlight('LspDiagnosticsSignHint', '#2D2D2D', g:custom_color_white)
        " New
        call s:highlight('DiagnosticSignError', '#2D2D2D', g:custom_color_red)
        call s:highlight('DiagnosticSignWarning', '#2D2D2D', g:custom_color_yellow)
        call s:highlight('DiagnosticSignInformation', '#2D2D2D', g:custom_color_white)
        call s:highlight('DiagnosticSignHint', '#2D2D2D', g:custom_color_white)
    augroup END
endfunction

" Legacy
sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
" New
sign define DiagnosticSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
sign define DiagnosticSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
sign define DiagnosticSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
sign define DiagnosticSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=

call BlackColor()
execute 'colorscheme '.g:colorscheme_current

function! ToggleLightDarkTheme()
    if g:colorscheme_current ==# g:colorscheme_dark
        call WhiteColor()
        let g:colorscheme_current  = g:colorscheme_light
    else
        call BlackColor()
        let g:colorscheme_current  = g:colorscheme_dark
    endif

    execute 'colorscheme '.g:colorscheme_current
endfunction

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

function! NewFile()
  let curline = getline('.')
  call inputsave()
  let l:name = input('[New File] Name : ')
  call inputrestore()
  execute 'e '.l:name
  w
  NvimTreeRefresh
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

function! FindWordUnderCursorInBuffers()
    let wordUnderCursor = expand("<cword>")
    execute 'Ack! '.wordUnderCursor
endfunction

function! FindInBuffer()
  let curline = getline('.')
  call inputsave()
  let pattern = input('[FIND IN BUFFERS] Pattern : ')
  call inputrestore()
  let vim_command = 'Ack! '.pattern
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
                \s:name[0:7] !=# 'NvimTree'
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

lua << EOF
require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('projects')
EOF

" File Keybindings
call vmenu#commands([
            \['f', 'Find Files',  'Telescope find_files'],
            \['l', 'Find Lines',  'Telescope live_grep'],
            \['p', 'Find Projects',  'Telescope projects'],
            \['x', 'Find Xdg Open',  'call fzf#run(fzf#wrap({"sink": "silent !xdg-open"}))'],
            \['t', 'Focus Tree',  'NvimTreeFindFile'],
            \['c', 'Close Tree',  'NvimTreeClose'],
            \['r', 'Refresh Tree',  'NvimTreeRefresh'],
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

function! basic#git_save()
    call terminal#run_command('git add --all')
    call basic#git_commit()
    call terminal#run_command('git push')
endfunction

" LATEX FIX
let g:tex_flavor = "latex"

" Git integration
lua require('gitsigns').setup()

" Git Keybindings
call vmenu#commands([
            \['s', 'Status',  'Telescope git_status'],
            \['t', 'Stash',  'Telescope git_stash'],
            \['T', 'Toggle Signs',  'Gitsigns toggle_signs'],
            \['b', 'Show Branches',  'Telescope git_branches'],
            \['m', 'Checkout master',  'call terminal#run_command("git checkout master")'],
            \['l', 'List Buffer Commits',  'Telescope git_bcommits'],
            \['p', 'Pull',  'call terminal#run_command("git pull")'],
            \['S', 'Save All',  'call basic#git_save()'],
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

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-d': 'bdelete',
  \ 'ctrl-v': 'vsplit' }

" Buffer Keybindings
call vmenu#commands([
            \['g', 'GoTo Buffer', 'call GoToBuffer()'],
            \['d', 'Delete Buffer', 'call DeleteBuffer()'],
            \['q', 'Delete Current Buffer', 'bd'],
            \['D', 'Delete All Buffers', 'call DeleteAllBuffers()'],
            \['s', 'Find Word Under Cursor in Buffers', 'call FindWordUnderCursorInBuffers()'],
            \['f', 'Find In Buffer', 'call FindInBuffer()'],
            \['b', 'List All Buffers', 'Telescope buffers'],
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
            \['t', 'Tree', 'NvimTreeFindFile'],
            \['c', 'Theme Light/Dark', 'call ToggleLightDarkTheme()'],
        \], {
            \'parent': g:keybindings_ui
        \})

" Simple Keybindings
call vmenu#commands([
            \['Q', 'Quit All', 'qa'],
            \['q', 'Quit', 'q'],
            \['S', 'Save All Files', 'wa'],
        \])
