" Julia-Vim Settings
let g:latex_to_unicode_auto = 1
let g:default_julia_version = '1.3'

" Language Serveur Settings
lua require'lspconfig'.julials.setup{}
call RegisterKeybindingsLSP('julia')

" Other Settings
let g:autoformat_on_save['julia'] = 0
call RegisterKeybindingsLSP('julia')

let g:repl_terminal_julia = g:ReplTerminal.new("julia\n
                \using Pkg\n
                \Pkg.activate(\".\")\n
                \using Revise
            \")

call terminal#repl_setup('julia', 'g:repl_terminal_julia')

" Test Utilities
let g:JuliaTest = {}
function g:JuliaTest.new()
    let l:newJuliaTest =  g:Test.new({
            \'root_src' : 'src',
            \'root_test' : 'test',
            \'suffix_src' : '',
            \'suffix_test' : '',
            \})

    return extend(l:newJuliaTest, copy(self))
endfunction

function g:JuliaTest.test_file()
    let l:file = @%

    if !self._is_test(l:file)
        let l:file = self._test_name(l:file)
    endif

    call self._test_file(l:file)
endfunction

function g:JuliaTest.test_suite()
    call self._test_file(self.root_test.'/runtests.jl')
endfunction

if !exists('g:julia_bin')
    let g:julia_bin='julia'
end

function g:JuliaTest._test_file(file)
    let l:pwd = trim(execute('pwd'))
    call terminal#run_command(g:julia_bin." --color=yes -e '
                \using Pkg;
                \Pkg.activate(\"".l:pwd."\");
                \include(\"".l:pwd.'/'.a:file."\");
                \'")
endfunction

let s:test_utils = g:JuliaTest.new()

function! lang#julia#test_toggle()
    call s:test_utils.toggle()
endfunction

function! lang#julia#test_file()
    call s:test_utils.test_file()
endfunction

function! lang#julia#test_suite()
    call s:test_utils.test_suite()
endfunction

function! lang#julia#run_file()
    let l:file = @%
    call terminal#run_command(g:julia_bin.' '.l:file)
endfunction

function! lang#julia#include_file()
    let l:file = @%
    let l:command = "include(\"".l:file."\")"
    call g:repl_terminal_julia.run(l:command)
endfunction

" Additional Key Bindings
call vmenu#commands([
            \['i', 'REPL Include File', 'call lang#julia#include_file()'],
        \], {
            \'parent': g:keybindings_interactive,
            \'filetype': 'julia'
        \})

call vmenu#commands([
            \['e', 'Execute file', 'call lang#julia#run_file()'],
            \['t', 'Test file', 'call lang#julia#test_file()'],
            \['s', 'Test Suite', 'call lang#julia#test_suite()'],
        \], {
            \'parent': g:keybindings_refactor_run,
            \'filetype': 'julia'
        \})

call vmenu#commands([
            \['t', 'Test - Impl', 'call lang#julia#test_toggle()'],
        \], {
            \'parent': g:keybindings_jumps_jobs,
            \'filetype': 'julia'
        \})
