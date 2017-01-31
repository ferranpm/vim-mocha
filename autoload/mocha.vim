function! mocha#SearchLine(pattern)
    let l:pos = getpos('.')
    execute '?'.a:pattern
    let l:line = getline('.')
    call setpos('.', l:pos)
    return l:line
endfunction

function! mocha#GetLine(pattern)
    let l:line = getline('.')
    return mocha#LineMatches(a:pattern) ? l:line : mocha#SearchLine(a:pattern)
endfunction

let s:patterns = {
            \ 'test': '\s*it\s*(\|\s*describe\s*(',
            \ 'description': '\s*describe\s*('
            \ }

function! mocha#Run(test, debug)
    let s:lastTest = a:test
    try
        let l:compiler_cmd = exists('b:current_compiler') ? '| compiler '.b:current_compiler : ''
        let l:inspect = a:debug ? ' --inspect --debug-brk' : ''
        compiler mocha
        execute 'make! -g ' .shellescape(a:test['name']) . ' ' . a:test['filename'] . l:inspect . l:compiler_cmd
    catch
        echoerr 'No test found'
    endtry
endfunction

function! mocha#createTest(name, filename)
    return { 'name': a:name, 'filename': a:filename }
endfunction

function! mocha#RunTest(debug)
    let l:name = mocha#ParseName(mocha#GetLine(s:patterns['test']))
    let l:test = mocha#createTest(l:name, expand('%'))
    call mocha#Run(l:test, a:debug)
endfunction

function! mocha#RunDescription(debug)
    let l:name = mocha#ParseName(mocha#GetLine(s:patterns['description']))
    let l:test = mocha#createTest(l:name, expand('%'))
    call mocha#Run(l:test, a:debug)
endfunction

function! mocha#RunLast(debug)
    call mocha#Run(s:lastTest, a:debug)
endfunction

function! mocha#ParseName(line)
    let l:quotedName = matchstr(a:line, "['\"].*['\"]")
    return strpart(l:quotedName, 1, strlen(l:quotedName) - 2)
endfunction

function! mocha#LineMatches(pattern)
    return match(getline('.'), a:pattern) >= 0
endfunction
