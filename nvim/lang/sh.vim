" Language Serveur Settings
lua << EOF
require'lspconfig'.bashls.setup {}
EOF
call RegisterKeybindingsLSP('sh')
