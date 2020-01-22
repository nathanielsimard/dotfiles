let g:LanguageClient_serverCommands['tex'] = ['~/.local/bin/tex-lsp']

call Keybinding_lsp('tex')

function! CompileLatex()
    let l:file = @%
    call RunWithTerminal('pdflatex -interaction=nonstopmode -synctex=1 '.l:file)
endfunction

function! SyncTexForward()
    execute 'silent !zathura --synctex-forward '.line('.').':'.col('.').':%:p %:p:r.pdf &'
endfunction

call vmenu#commands([
            \['c', 'Compile', 'call CompileLatex()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'tex'
        \})

call vmenu#commands([
            \['v', 'View PDF Output', 'call SyncTexForward()'],
        \], {
            \'parent': g:keybindings_file,
            \'filetype': 'tex'
        \})
