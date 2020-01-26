" Julia-Vim Settings
let g:latex_to_unicode_auto = 1
let g:default_julia_version = '1.3'

" LanguageServer Settings
let g:LanguageClient_useVirtualText = 'No'
let g:LanguageClient_serverCommands['julia'] = [
        \   'julia',
        \   '--startup-file=no',
        \   '--history-file=no',
        \   '-e', '
        \       using LanguageServer;
        \       using Pkg;
        \       import StaticLint;
        \       import SymbolServer;
        \       env_path = dirname(Pkg.Types.Context().env.project_file);
        \       debug = false; 
        \       
        \       server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
        \       server.runlinter = true;
        \       run(server);
        \   ']

" Other Settings
let g:autoformat_on_save['julia'] = 0
call RegisterKeybindingsLSP('julia')

function! RunJulia()
    let l:file = @%
    call RunWithTerminal('julia '.l:file)
endfunction

call vmenu#commands([
            \['e', 'Execute file', 'call RunJulia() '],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'julia'
        \})


