let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#revert#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#refs()
  endif
endfunction


let s:options = ['--edit', '--mainline', '--no-edit',
\                '--no-commit', '--signoff']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
