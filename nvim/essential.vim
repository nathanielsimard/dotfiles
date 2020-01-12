" LanguageClient Settings
function! Keybinding_lsp(filetype)
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
                \['l', 'LSP Options', 'call LanguageClient_contextMenu()()'],
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

let g:LanguageClient_serverCommands = {}
let g:LanguageClient_settingsPath = '~/.config/nvim/settings.json'
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0
call LanguageClient#setLoggingLevel('ERROR')

" Tagbar Settings
let g:tagbar_map_showproto='a'

" Deoplete Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:deoplete#enable_at_startup = 1

" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_check_on_open = 1

call vmenu#commands([
            \['n', 'Next Error', 'lnext'],
            \['p', 'Previous Error', 'lprev']
        \], {
            \'parent': g:keybindings_error
        \})

" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

call vmenu#commands([
            \['n', 'Test Nearest',  'TestNearest'],
            \['f','Test File', 'TestFile'],
            \['s', 'Test Suite', 'TestSuite'],
            \['l', 'Test Last', 'TestLast'],
            \['v', 'Test Visit', 'TestVisit']
        \], {
            \'parent': g:keybindings_test
        \})

call vmenu#commands([
            \['o', 'Outline',  'TagbarToggle']
        \], {
            \'parent': g:keybindings_help
        \})

