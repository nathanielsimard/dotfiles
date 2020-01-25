" LanguageClient Settings
let g:LanguageClient_serverCommands = {}
let g:LanguageClient_diagnosticsEnable = 0

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
