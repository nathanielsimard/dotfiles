lua << EOF
register_autocomplete_lsp('taplo')
require'lspconfig'.taplo.setup{}
EOF

call RegisterKeybindingsLSP('toml')


