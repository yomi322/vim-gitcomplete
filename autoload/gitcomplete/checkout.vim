let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#checkout#complete(arglead, cmdline)
  if gitcomplete#utils#has_arg(a:cmdline, '--')
    return vimshell#complete#helper#files(a:arglead)
  elseif a:arglead =~# '^--conflict='
    return gitcomplete#utils#to_comp(['--conflict=diff3',
    \                                 '--conflict=merge'])
  elseif a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#refs() +
    \      vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let s:options = ['--quiet',
\                '--ours',
\                '--theirs',
\                '--track',
\                '--no-track',
\                '--merge',
\                '--conflict=',
\                '--orphan',
\                '--patch']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
