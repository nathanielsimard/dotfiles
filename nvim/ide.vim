let g:autoformat_on_save = {}
function! FormatFiletype()
    if !has_key(g:autoformat_on_save, &filetype)
        return
    endif

    if get(g:autoformat_on_save, &filetype) ==# 1
        lua vim.lsp.buf.formatting()
    end
endfunction

augroup Autoformat
    autocmd BufWritePre * call FormatFiletype()
augroup END

function! RegisterKeybindingsLSP(filetype)
    call vmenu#commands([
                \['j', 'Next', 'NextDiagnosticCycle'],
                \['k', 'Prev', 'PrecDiagnosticCycle'],
        \], {
            \'parent': g:keybindings_error,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Show Documentation', 'lua vim.lsp.buf.hover()']
        \], {
            \'parent': g:keybindings_documentation,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['a', 'Code Action', 'lua vim.lsp.buf.code_action()'],
                \['c', 'Completion', 'lua vim.lsp.buf.completion()'],
                \['r', 'Highlight References', 'lua vim.lsp.buf.document_highlight()']
        \], {
            \'parent': g:keybindings_help,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['d', 'Definition', 'lua vim.lsp.buf.definition()'],
                \['i', 'Implementation', 'lua vim.lsp.buf.implementation()'],
                \['r', 'References', 'lua vim.lsp.buf.references()'],
                \['s', 'Symbol', 'lua vim.lsp.buf.document_symbol()']
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': a:filetype
        \})

    call vmenu#commands([
                \['r', 'Rename', 'lua vim.lsp.buf.rename()'],
                \['f', 'Format', 'lua vim.lsp.buf.formatting()'],
                \['F', 'Range Format', 'lua vim.lsp.buf.range_formatting()']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': a:filetype
        \})
endfunction

" Completion Settings
autocmd BufEnter * lua require'completion'.on_attach()
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']
lua << EOF
completion_chain_complete_list = {
  { complete_items = { 'lsp' } },
  { complete_items = { 'buffers' } },
}
EOF

" Diagnotic Lsp Setting
let g:diagnostic_enable_virtual_text = 1
let g:space_before_virtual_text = 5

" Neomake Settings
call neomake#configure#automake('w')
let g:neomake_check_on_open = 1

" Spelling Settings
function! ToggleSpelling()
    if &spell ==# 1
        setlocal nospell
    else
        setlocal spell
    endif
endfunction

call vmenu#commands([
            \['g', 'Check Grammar', 'GrammarousCheck  --preview'],
            \['r', 'Reset Grammar', 'GrammarousReset'],
            \['s', 'Toggle Spelling', 'call ToggleSpelling()'],
            \['c', 'Correct Spelling', 'normal! z='],
            \['n', 'Next Spelling Error', 'normal! [s'],
            \['n', 'Previous Spelling Error', 'normal! ]s'],
    \], {
        \'parent': g:keybindings_spelling
    \})
