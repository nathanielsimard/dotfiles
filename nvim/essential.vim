" LanguageClient Settings
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsEnable = 0
"let $LANGUAGECLIENT_DEBUG=1
"let g:LanguageClient_loggingLevel='DEBUG'
let g:LanguageClient_loggingFile = '/home/nathaniel/LanguageClient.log'
let g:LanguageClient_serverStderr = '/home/nathaniel/LanguageServer.log'

let g:autoformat_on_save = {}
function! FormatFiletype()
    if !has_key(g:autoformat_on_save, &filetype)
        return
    endif

    if get(g:autoformat_on_save, &filetype) ==# 1
        call LanguageClient#textDocument_formatting_sync()
    end
endfunction

augroup Autoformat
    autocmd BufWritePre * call FormatFiletype()
augroup END

function! RegisterKeybindingsLSP(filetype)
    call vmenu#commands([
                \['e', 'Explain', 'call LanguageClient#explainErrorAtPoint()'],
                \['l', 'List', 'call LanguageClient#setDiagnosticsList()']
        \], {
            \'parent': g:keybindings_error,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Show Documentation', 'call LanguageClient#textDocument_hover()']
        \], {
            \'parent': g:keybindings_documentation,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['l', 'LSP Options', 'call LanguageClient_contextMenu()'],
                \['a', 'Code Action', 'call LanguageClient#textDocument_codeAction()'],
                \['c', 'Completion', 'call LanguageClient#textDocument_completion()'],
                \['r', 'Highlight References', 'call LanguageClient#textDocument_documentHighlight()']
        \], {
            \'parent': g:keybindings_help,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Definition', 'call LanguageClient#textDocument_definition()'],
                \['i', 'Implementation', 'call LanguageClient#textDocument_implementation()'],
                \['r', 'References', 'call LanguageClient#textDocument_references()'],
                \['s', 'Symbol', 'call LanguageClient#textDocument_documentSymbol()']
        \], {
            \'parent': g:keybindings_goto,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['r', 'Rename', 'call LanguageClient#textDocument_rename()'],
                \['f', 'Format', 'call LanguageClient#textDocument_formatting()'],
                \['F', 'Range Format', 'call LanguageClient#textDocument_rangeFormatting()']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': a:filetype
        \})
endfunction

" Deoplete Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:deoplete#enable_at_startup = 1

" Echo Doc Settings
let g:echodoc#enable_at_startup = 1
set completeopt-=preview
let g:echodoc#type = 'floating'
highlight link EchoDocFloat Pmenu

" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_check_on_open = 1

" Spelling Settings
function! ToggleSpelling()
    if &spell ==# 1
        setlocal nospell
    else
        setlocal spell
    endif
endfunction

""" RELP Settings
let g:repl_neoterm_id = -1
xmap <space> <Plug>(neoterm-repl-send)

function! OpenREPL()
    if g:repl_neoterm_id ==# -1
        let g:neoterm_current_term_id = g:neoterm_current_term_id + 1
        let g:repl_neoterm_id = g:neoterm_current_term_id
    endif

    Tnew
    execute 'TREPLSetTerm '.g:repl_neoterm_id
endfunction

function! ToggleREPL()
    execute g:repl_neoterm_id.'Ttoggle'
endfunction

function! CloseREPL()
    execute g:repl_neoterm_id.'Tclose!'
    let g:repl_neoterm_id = -1
endfunction

call vmenu#commands([
            \['f', 'REPL Send File', 'TREPLSendFile'],
            \['v', 'REPL Visual Mode', 'echo "Use `<space>` in visual mode to send text to REPL"'],
            \['l', 'REPL Send Line', 'TREPLSendLine'],
            \['t', 'REPL Toggle', 'call ToggleREPL()'],
            \['c', 'REPL close', 'call CloseREPL()'],
            \['o', 'REPL open', 'call OpenREPL()'],
        \], {
            \'parent': g:keybindings_interactive,
        \})


call vmenu#commands([
            \['g', 'Check Grammar', 'GrammarousCheck  --preview'],
            \['r', 'Reset Grammar', 'GrammarousReset'],
            \['s', 'Toggle Spelling', 'call ToggleSpelling()'],
            \['c', 'Correct Spelling', 'normal! z='],
            \['n', 'Next Spelling Error', 'normal! [s'],
            \['n', 'Previous Spelling Error', 'normal! ]s'],
    \], {
        \'parent': g:keybindings_spelling
    \})

" Test Settings
call vmenu#commands([
            \['n', 'Test Nearest',  'TestNearest'],
            \['f','Test File', 'TestFile'],
            \['s', 'Test Suite', 'TestSuite'],
            \['p', 'Test Previous', 'TestLast'],
            \['v', 'Test Visit', 'TestVisit']
        \], {
            \'parent': keybindings_test_tab
        \})
