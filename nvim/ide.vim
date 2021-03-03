" Utilities
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
                \['s', 'Show', 'lua vim.lsp.diagnostic.show_line_diagnostics()'],
                \['j', 'Next', 'lua vim.lsp.diagnostic.goto_next()'],
                \['k', 'Prev', 'lua vim.lsp.diagnostic.goto_prev()'],
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
                \['s', 'Signature', 'lua vim.lsp.buf.signature_help()'],
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
let g:completion_auto_change_source = 1
let g:completion_chain_complete_list = [
    \{'complete_items': ['lsp']},
    \{'complete_items': ['buffers']},
    \{'mode': '<c-p>'},
    \{'mode': '<c-n>'}
\]

autocmd BufEnter * lua require'completion'.on_attach()
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

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
