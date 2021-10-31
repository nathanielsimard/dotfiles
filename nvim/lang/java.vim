" Language Serveur Settings
lua << EOF
require'lspconfig'.java_language_server.setup {
    filetypes = { "java" },
    cmd = { "java-language-server" },
}
EOF
call RegisterKeybindingsLSP('java')
