" Language Serveur Settings
lua << EOF
vim.lsp.config('bashls', {})
vim.lsp.enable('bashls')
EOF
call RegisterKeybindingsLSP('sh')
