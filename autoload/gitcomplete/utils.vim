let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#utils#to_comp(list)
  return map(a:list, "{ 'word': v:val, 'menu': 'git' }")
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
