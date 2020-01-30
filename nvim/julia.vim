let g:neomake_julia_enabled_makers = ['lint']
" Julia-Vim Settings
let g:latex_to_unicode_auto = 1
let g:default_julia_version = '1.3'

" LanguageServer Settings
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_serverCommands['julia'] = ['julia-lsp']

" Other Settings
let g:autoformat_on_save['julia'] = 0
call RegisterKeybindingsLSP('julia')

function! RunJulia()
    let l:file = @%
    call RunWithTerminal('julia '.l:file)
endfunction

function! SourceJulia()
    let l:file = @%
    execute "Texec include(\"".l:file."\")"
endfunction

function! RunJuliaTest()
    let l:file = @%
    let l:pwd = trim(execute('pwd'))
    call RunWithTerminal("julia --color=yes -e '
                \using Pkg;
                \Pkg.activate(\"".l:pwd."\");
                \include(\"".l:pwd.'/'.l:file."\");
                \'")
endfunction

call vmenu#commands([
            \['u', 'REPL Update File', 'call SourceJulia() '],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'julia'
        \})


call vmenu#commands([
            \['e', 'Execute file', 'call RunJulia() '],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'julia'
        \})

call vmenu#commands([
            \['f', 'Test file', 'call RunJuliaTest() '],
        \], {
            \'parent': g:keybindings_test_tab,
            \'filetype': 'julia'
        \})
