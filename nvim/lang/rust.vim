lua << EOF
register_autocomplete_lsp('rust_analyzer')
vim.lsp.config('rust_analyzer', {
    diagnostic = {
        enable = true;
    }
})
vim.lsp.enable('rust_analyzer')
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
