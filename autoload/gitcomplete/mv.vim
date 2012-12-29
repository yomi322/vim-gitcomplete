let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#mv#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return gitcomplete#utils#to_comp(['--dry-run'])
  else
    return vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
