let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#branch#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return copy(s:options)
  elseif s:only_local_refs(a:cmdline)
    return gitcomplete#utils#heads()
  else
    return gitcomplete#utils#refs()
  endif
endfunction


function! s:only_local_refs(cmdline)
  return !gitcomplete#utils#has_arg(a:cmdline, '-r') &&
  \      (gitcomplete#utils#has_arg(a:cmdline, '-m') ||
  \       gitcomplete#utils#has_arg(a:cmdline, '-d'))
endfunction


let s:options = ['--color',
\                '--no-color',
\                '--verbose',
\                '--abbrev=',
\                '--no-abbrev',
\                '--track',
\                '--no-track',
\                '--contains',
\                '--merged',
\                '--no-merged',
\                '--set-upstream-to=',
\                '--edit-description',
\                '--list',
\                '--unset-upstream']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
