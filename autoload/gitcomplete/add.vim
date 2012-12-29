let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#add#complete(arglead, cmdline)
  if !gitcomplete#utils#has_arg(a:cmdline, '--') &&
  \  a:arglead =~# '^--'
    return copy(s:options)
  else
    return vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let s:options = ['--interactive',
\                '--refresh',
\                '--patch',
\                '--update',
\                '--dry-run',
\                '--ignore-errors',
\                '--intent-to-add']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
