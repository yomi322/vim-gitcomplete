let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#cherry_pick#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return gitcomplete#utils#to_comp(['--edit', '--no-commit'])
  else
    return gitcomplete#utils#refs()
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
