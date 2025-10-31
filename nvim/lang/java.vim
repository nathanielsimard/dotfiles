call RegisterKeybindingsLSP('java')
lua vim.lsp.config('jdtls', {})
lua vim.lsp.enable('jdtls')

" Test Utilities
if !exists('g:java_project_root')
    let g:java_project_root='src/main'
end

if !exists('g:java_project_tests_root')
    let g:java_project_tests_root='src/test'
end

let s:test_utils =  g:Test.new({
            \'root_src' : g:java_project_root,
            \'root_test' : g:java_project_tests_root,
            \'suffix_src' : '.java',
            \'suffix_test' : 'Test.java',
            \'runner_test' : 'mvn test',
            \})

function! lang#java#test_toggle()
    call s:test_utils.toggle()
endfunction

function! lang#java#test_class()
    let s:wordUnderCursor = expand("<cword>")
    let s:command = 'mvn test -Dtest='.s:wordUnderCursor
    call terminal#run_command(s:command)
endfunction

function! lang#java#test_suite()
    call terminal#run_command('mvn test')
endfunction

" Run Settings
call vmenu#commands([
            \['t','Test Class', 'call lang#java#test_class()'],
            \['s','Test Suite', 'call lang#java#test_suite()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'java'
        \})
call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#java#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'java'
        \})
