" Language Serveur Settings
lua require'lspconfig'.texlab.setup{}
call RegisterKeybindingsLSP('tex')

" Fix linting issues
autocmd FileType tex :call TexNewMathZone("E","align",1)

function! CompileLatex()
    let l:file = @%
    call terminal#run_command('pdflatex -interaction=nonstopmode -synctex=1 '.l:file)
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
