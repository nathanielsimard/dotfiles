lua << EOF
require'lspconfig'.rls.setup{}
EOF
call RegisterKeybindingsLSP('rust')
