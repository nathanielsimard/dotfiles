" Language Serveur Settings
lua vim.lsp.config('marksman', {})
lua vim.lsp.enable('marksman')
call RegisterKeybindingsLSP('markdown')

" Formatteur Settings
function! lang#markdown#format()
    w
    let l:file = @%
    let l:cmd = 'silent !prettier -w '.l:file
    execute l:cmd
    e
endfunction

call vmenu#commands([
            \['f','Format', 'call lang#markdown#format()'],
            \['p', 'Markdown Preview', 'MarkdownPreview'],
            \['s', 'Stop Markdown Preview', 'MarkdownPreviewStop']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'markdown'
        \})

