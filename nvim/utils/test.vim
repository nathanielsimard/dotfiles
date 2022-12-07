let g:Test = {}
function g:Test.new(...)
    let l:options = {
                \'root_src': 'src',
                \'root_test': 'test',
                \'suffix_src': '',
                \'suffix_test': '',
                \'runner_test': '',
                \}
    if a:0 > 0
        let l:options = extend(l:options, a:1)
    end

    let l:newTestToggle = copy(self)
    let l:newTestToggle.root_src = l:options['root_src']
    let l:newTestToggle.root_test = l:options['root_test']
    let l:newTestToggle.suffix_src = l:options['suffix_src']
    let l:newTestToggle.suffix_test = l:options['suffix_test']
    let l:newTestToggle.runner_test = l:options['runner_test']

    return l:newTestToggle
endfunction

function g:Test.toggle()
    let l:file = expand("%:~:.")
    if self._is_test(l:file)
        let l:file = self._src_name(l:file)
    else
        let l:file = self._test_name(l:file)
    endif

    execute 'e '.l:file
endfunction

function g:Test.test_file()
    let l:file = expand("%:~:.")

    if !self._is_test(l:file)
        let l:file = self._test_name(l:file)
    endif

    call terminal#run_command(self.runner_test.' '.l:file)
endfunction

function g:Test._is_test(file)
    let l:size_root = len(self.root_test) - 1
    let l:from_root = a:file[:l:size_root] ==# self.root_test
    let l:size_suffix = len(self.suffix_test)
    let l:from_suffix = a:file[-l:size_suffix:] ==# self.suffix_test

    " If no root_test is specified
    if len(self.root_test) ==# 0
        let l:from_root = 1
    endif

    return l:from_root && l:from_suffix
endfunction

function g:Test._test_name(file)
    let l:test_file = a:file
    let l:test_file = l:test_file[0:len(l:test_file) - len(self.suffix_src) - 1]
    let l:test_file = l:test_file.self.suffix_test

    let l:test_file = substitute(l:test_file, self.root_src, self.root_test, '')

    return l:test_file
endfunction

function g:Test._src_name(file)
    let l:src_file = a:file
    let l:src_file = substitute(l:src_file, self.suffix_test, self.suffix_src, '')
    let l:src_file = substitute(l:src_file, self.root_test, self.root_src, '')

    return l:src_file
endfunction
