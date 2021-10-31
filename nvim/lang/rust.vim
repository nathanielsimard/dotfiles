lua << EOF
require'lspconfig'.rust_analyzer.setup{}
require'rust-tools'.setup{}
EOF
call RegisterKeybindingsLSP('rust')

" Run Settings
call vmenu#commands([
            \['h', 'Hover Actions', 'RustHoverActions'],
            \['a', 'Code Actions', 'RustCodeAction'],
            \['R','Show Runnables', 'RustRunnables'],
            \['d','Debug', 'RustDebuggables'],
            \['t','Run Test', 'RustTest'],
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
