let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#reflog#complete(arglead, cmdline)
  if !gitcomplete#utils#has_arg(a:cmdline, copy(s:subcommand))
    return gitcomplete#utils#to_comp(copy(s:subcommand))
  else
    return gitcomplete#utils#refs()
  endif
endfunction


let s:subcommand = ['show', 'delete', 'expire']


let &cpo = s:save_cpo
unlet s:save_cpo
