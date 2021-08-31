" Language Serveur Settings
lua << EOF
require'lspconfig'.java_language_server.setup {
    filetypes = { "java" },
    on_attach = require'completion'.on_attach,
    cmd = { "java-language-server" },
}
EOF
call RegisterKeybindingsLSP('java')
