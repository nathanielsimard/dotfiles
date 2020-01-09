""" LanguageClient Settings
function! Keybinding_lsp(filetype)
    call g:keybindings_error.add_filetype(a:filetype, vmenu#keybinding#command#new('e', 'Explain', 'call LanguageClient#explainErrorAtPoint()'))
    call g:keybindings_error.add_filetype(a:filetype, vmenu#keybinding#command#new('l', 'List', 'call LanguageClient#setDiagnosticsList()'))

    call g:keybindings_documentation.add_filetype(a:filetype, vmenu#keybinding#command#new('d', 'Show Documentation', 'call LanguageClient#textDocument_hover()'))

    call g:keybindings_help.add_filetype(a:filetype, vmenu#keybinding#command#new('l', 'LSP Options', 'call LanguageClient_contextMenu()()'))
    call g:keybindings_help.add_filetype(a:filetype, vmenu#keybinding#command#new('a', 'Code Action', 'call LanguageClient#textDocument_codeAction()'))
    call g:keybindings_help.add_filetype(a:filetype, vmenu#keybinding#command#new('c', 'Completion', 'call LanguageClient#textDocument_completion()'))
    call g:keybindings_help.add_filetype(a:filetype, vmenu#keybinding#command#new('r', 'Highlight References', 'call LanguageClient#textDocument_documentHighlight()'))

    call g:keybindings_goto.add_filetype(a:filetype, vmenu#keybinding#command#new('d', 'Definition', 'call LanguageClient#textDocument_definition()'))
    call g:keybindings_goto.add_filetype(a:filetype, vmenu#keybinding#command#new('i', 'Implementation', 'call LanguageClient#textDocument_implementation()'))
    call g:keybindings_goto.add_filetype(a:filetype, vmenu#keybinding#command#new('r', 'References', 'call LanguageClient#textDocument_references()'))
    call g:keybindings_goto.add_filetype(a:filetype, vmenu#keybinding#command#new('s', 'Symbol', 'call LanguageClient#textDocument_documentSymbol()'))

    call g:keybindings_refactor_run.add_filetype(a:filetype, vmenu#keybinding#command#new('r', 'Raname', 'call LanguageClient#textDocument_rename()'))
    call g:keybindings_refactor_run.add_filetype(a:filetype, vmenu#keybinding#command#new('f', 'Format', 'call LanguageClient#textDocument_formatting()'))
    call g:keybindings_refactor_run.add_filetype(a:filetype, vmenu#keybinding#command#new('F', 'Range Format', 'call LanguageClient#textDocument_rangeFormatting()'))
endfunction

let g:LanguageClient_serverCommands = {}
let g:LanguageClient_hoverPreview='Always'
let g:LanguageClient_diagnosticsEnable=0
call LanguageClient#setLoggingLevel('ERROR')

""" Tagbar Settings
let g:tagbar_map_showproto='a'

""" Deoplete Settings
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
inoremap <expr><S-TAB>  pumvisible() ? "\<C-p>" : "\<S-TAB>"
let g:deoplete#enable_at_startup = 1

""" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_check_on_open = 1
call g:keybindings_error.add(vmenu#keybinding#command#new('n', 'Next Error', 'lnext'))
call g:keybindings_error.add(vmenu#keybinding#command#new('p', 'Previous Error', 'lprev'))

""" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

call g:keybindings_test.add(vmenu#keybinding#command#new('n', 'Test Nearest',  'TestNearest'))
call g:keybindings_test.add(vmenu#keybinding#command#new('f','Test File', 'TestFile'))
call g:keybindings_test.add(vmenu#keybinding#command#new('s', 'Test Suite', 'TestSuite'))
call g:keybindings_test.add(vmenu#keybinding#command#new('l', 'Test Last', 'TestLast'))
call g:keybindings_test.add(vmenu#keybinding#command#new('v', 'Test Visit', 'TestVisit'))

call g:keybindings_help.add(vmenu#keybinding#command#new('o', 'Outline',  'TagbarToggle'))

