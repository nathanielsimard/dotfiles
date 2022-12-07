let g:vim_svelte_plugin_load_full_syntax = 1
let g:vim_svelte_plugin_use_typescript = 1
let g:vim_svelte_plugin_use_sass = 1

lua require'lspconfig'.svelte.setup{}
call RegisterKeybindingsLSP('svelte')
