lua << EOF
register_autocomplete_lsp('rust_analyzer')
require'lspconfig'.rust_analyzer.setup{}
EOF

call RegisterKeybindingsLSP('rust')


function! lang#rust#format_file()
    let l:file = @%
    let l:cmd = "silent !cargo fmt -- ".l:file
    execute l:cmd
    e
endfunction

" Run Settings
call vmenu#commands([
            \['f','Format file', 'call lang#rust#format_file()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'rust'
        \})
