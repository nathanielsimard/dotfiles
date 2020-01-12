let g:LanguageClient_serverCommands['tex'] = ['~/.local/bin/tex-lsp']
call Keybinding_lsp('tex')

function! CompileLatex()
    let l:file = @%
    call RunWithTerminal('pdflatex -interaction=nonstopmode '.l:file)
endfunction

call vmenu#commands([
            \['c', 'Compile', 'call CompileLatex()']
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'tex'
        \})
