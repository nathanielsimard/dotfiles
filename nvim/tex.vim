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
            \['s', 'Sync Tex', 'call SyncTexForward()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'tex'
        \})
