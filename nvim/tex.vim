let g:LanguageClient_serverCommands['tex'] = ['~/.local/bin/tex-tsp']
call Keybinding_lsp('tex')

function! CompileLatex()
    let l:file = @%
    call RunWithTerminal('pdflatex '.l:file)
endfunction

call g:keybindings_refactor_run.add_filetype('tex', vmenu#keybinding#command#new('c', 'Compile', 'call CompileLatex()'))

