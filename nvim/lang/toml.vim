lua << EOF
register_autocomplete_lsp('taplo')
vim.lsp.config('taplo', {})
vim.lsp.enable('taplo')
EOF

call RegisterKeybindingsLSP('toml')


