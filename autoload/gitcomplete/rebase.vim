let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#rebase#complete(arglead, cmdline)
  let gitdir = gitcomplete#utils#get_gitdir()
  if filereadable(gitdir . '/rebase-apply') ||
  \  filereadable(gitdir . '/rebase-merge')
    return gitcomplete#utils#to_comp(['--continue', '--skip', '--abort'])
  elseif a:arglead =~# '^--whitespace='
    return gitcomplete#utils#to_comp(
    \        map(['nowarn', 'warn', 'error', 'error-all', 'fix'],
    \            "'--whitespace=' . v:val"))
  elseif a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#refs()
  endif
endfunction


let s:options = ['--onto',
\                '--merge',
\                '--strategy',
\                '--interactive',
\                '--preserve-merges',
\                '--stat',
\                '--no-stat',
\                '--committer-date-is-author-date',
\                '--ignore-date',
\                '--ignore-whitespace',
\                '--whitespace=',
\                '--autosquash']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
