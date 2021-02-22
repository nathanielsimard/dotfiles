let g:neomake_typescript_eslint_exe = $PWD .'/node_modules/.bin/eslint'
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}
call RegisterKeybindingsLSP('typescript')

" Test Utilities
if !exists('g:typescript_project_root')
    let g:typescript_project_root=''
end

if !exists('g:typescript_project_tests_root')
    let g:typescript_project_tests_root=''
end

let s:test_utils =  g:Test.new({
            \'root_src' : g:typescript_project_root,
            \'root_test' : g:typescript_project_tests_root,
            \'suffix_src' : '.ts',
            \'suffix_test' : '.spec.ts',
            \'runner_test' : './node_modules/.bin/jest --coverage=False',
            \})

function! lang#typescript#test_toggle()
    call s:test_utils.toggle()
endfunction

function! lang#typescript#test_file()
    call s:test_utils.test_file()
endfunction

call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#typescript#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'typescript'
        \})

" Formatteur Settings
function! lang#typescript#format()
    lua vim.lsp.buf.formatting()
    w
    let l:file = @%
    let l:cmd = 'silent !./node_modules/.bin/eslint --fix '.l:file
    execute l:cmd
    e
endfunction

" Run Settings
call vmenu#commands([
            \['t','Test File', 'call lang#typescript#test_file()'],
            \['f','Format', 'call lang#typescript#format()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'typescript'
        \})

let g:repl_terminal_typescript = g:ReplTerminal.new('')
call terminal#repl_setup('typescript', 'g:repl_terminal_typescript')

function! lang#typescript#test_watch()
    let l:file = @%
    let l:command = './node_modules/.bin/jest --watch --coverage=false '.l:file
    call g:repl_terminal_typescript.run(l:command)
endfunction

call vmenu#commands([
            \['w', 'REPL Watch Test', 'call lang#typescript#test_watch()'],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'typescript'
        \})

