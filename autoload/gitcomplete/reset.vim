let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#reset#complete(arglead, cmdline)
  if gitcomplete#utils#has_arg(a:cmdline, '--')
    return vimshell#complete#helper#files(a:arglead)
  elseif a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#refs() +
    \      vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let s:options = ['--merge', '--mixed', '--hard', '--soft', '--patch']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
