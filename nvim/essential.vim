""" LanguageClient Settings
function! Keybinding_lsp(filetype)
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('d', 'Show Documentation', 'call LanguageClient#textDocument_hover()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('l', 'LSP Options', 'call LanguageClient_contextMenu()()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('s', 'Document Symbol', 'call LanguageClient#textDocument_documentSymbol()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'List References', 'call LanguageClient#textDocument_references()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('a', 'Code Action', 'call LanguageClient#textDocument_codeAction()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('c', 'Code Action', 'call LanguageClient#textDocument_completion()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'Highlight References', 'call LanguageClient#textDocument_documentHighlight()'))
    call g:keybindings_help.add_filetype(a:filetype, g:CommandKeybinding.new('e', 'Explain Error', 'call LanguageClient#explainErrorAtPoint()'))

    call g:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('d', 'Definition', 'call LanguageClient#textDocument_definition()'))
    call g:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('i', 'Implementation', 'call LanguageClient#textDocument_implementation()'))
    call g:keybindings_goto.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'References', 'call LanguageClient#textDocument_references()'))

    call g:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('r', 'Raname', 'call LanguageClient#textDocument_rename()'))
    call g:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('f', 'Format', 'call LanguageClient#textDocument_formatting()'))
    call g:keybindings_refactor.add_filetype(a:filetype, g:CommandKeybinding.new('F', 'Range Format', 'call LanguageClient#textDocument_rangeFormatting()'))

    call g:keybindings_error.add_filetype(a:filetype, g:CommandKeybinding.new('l', 'List', 'call LanguageClient#setDiagnosticsList()'))
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
let g:neomake_open_list = 1
let g:neomake_check_on_open = 1
call g:keybindings_error.add(g:CommandKeybinding.new('e', 'Next Error', 'lnext'))
call g:keybindings_error.add(g:CommandKeybinding.new('E', 'Previous Error', 'lprev'))

""" Test Settings
let test#strategy = 'neovim'
let g:test#preserve_screen = 1

call g:keybindings_test.add(g:CommandKeybinding.new('n', 'Test Nearest',  'TestNearest'))
call g:keybindings_test.add(g:CommandKeybinding.new('f','Test File', 'TestFile'))
call g:keybindings_test.add(g:CommandKeybinding.new('s', 'Test Suite', 'TestSuite'))
call g:keybindings_test.add(g:CommandKeybinding.new('l', 'Test Last', 'TestLast'))
call g:keybindings_test.add(g:CommandKeybinding.new('v', 'Test Visit', 'TestVisit'))

call g:keybindings_root.add(g:CommandKeybinding.new('c', 'Toggle CTags',  'TagbarToggle'))

