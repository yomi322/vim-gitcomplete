let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#merge#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#refs()
  endif
endfunction


let s:options = ['--no-commit',
\                '--no-stat',
\                '--log',
\                '--no-log',
\                '--squash',
\                '--strategy',
\                '--commit',
\                '--stat',
\                '--no-squash',
\                '--ff',
\                '--no-ff',
\                '--ff-only',
\                '--edit',
\                '--no-edit']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
