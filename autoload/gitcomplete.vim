let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#complete(arglead, cmdline)
  let command = s:get_command(a:cmdline)
  if command ==# ''
    return []
  else
    return []
  endif
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
