lua << EOF
register_autocomplete_lsp('rust_analyzer')
require'lspconfig'.rust_analyzer.setup{}
require'rust-tools'.setup{}
EOF
call RegisterKeybindingsLSP('rust')


function! lang#rust#format_file()
    let l:file = @%
    let l:cmd = "silent !cargo fmt -- ".l:file
    execute l:cmd
    e
endfunction

" Run Settings
" \['a', 'Code Actions', 'RustCodeAction'],
call vmenu#commands([
            \['h', 'Hover Actions', 'RustHoverActions'],
            \['R','Show Runnables', 'RustRunnables'],
            \['d','Debug', 'RustDebuggables'],
            \['t','Run Test', 'RustTest'],
            \['f','Format file', 'call lang#rust#format_file()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'rust'
        \})

call vmenu#commands([
            \['h', 'Show Hints', 'RustToggleInlayHints'],
        \], {
            \'parent': g:keybindings_ui,
            \'filetype': 'rust'
        \})
