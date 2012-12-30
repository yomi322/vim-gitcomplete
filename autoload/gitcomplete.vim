let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#complete(arglead, cmdline)
  let command = s:get_command(a:cmdline)
  if command ==# ''
    return gitcomplete#git#complete(a:arglead, a:cmdline)
  else
    let command = substitute(command, '-', '_', 'g')
    try
      return call('gitcomplete#' . command . '#complete',
      \           [a:arglead, a:cmdline])
    catch /^Vim\%((\a\+)\)\=:E117/
      return []
    endtry
  endif
endfunction


function! s:get_command(cmdline)
  let i = 0
  let len = len(a:cmdline) - 1
  while i < len
    let arg = a:cmdline[i]
    if arg ==# '--help'
      return 'help'
    elseif arg ==# '-c'
      let i = i + 1
    elseif arg !~# '^-'
      return arg
    endif
    let i = i + 1
  endwhile
  return ''
endfunction


function! s:get_aliased_command(command)
  let s = vimproc#system('git config --get alias.' . a:command)
  let expanded = vimproc#get_last_status() == 0 ? split(s) : []
  for w in expanded
    if w !~# '^!\|^-\|^git$'
      return w
    endif
  endfor
  return ''
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
