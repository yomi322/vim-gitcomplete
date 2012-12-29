let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#commit#complete(arglead, cmdline)
  if gitcomplete#utils#has_arg(a:cmdline, '--')
    return vimshell#complete#helper#files(a:arglead)
  elseif a:arglead =~# '^--cleanup='
    return gitcomplete#utils#to_comp(
    \        map(['default', 'strip', 'verbatim', 'whitespace'],
    \            "'--cleanup=' . v:val"))
  elseif a:arglead =~# '^--untracked-files='
    return gitcomplete#utils#to_comp(
    \        map(['all', 'no', 'normal'], "'--untracked-files=' . v:val"))
  elseif a:arglead =~#
  \        '^--reuse-message=\|^--reedit-message=\|^--fixup=\|^--squash='
    let o = matchstr(a:arglead, '\zs.\+=\ze')
    return gitcomplete#utils#to_comp(
    \        map(gitcomplete#utils#refs(), 'o . v:val.word'))
  elseif a:arglead =~# '^--'
    return copy(s:options)
  else
    return []
  endif
endfunction


let s:options = ['--all',
\                '--author=',
\                '--signoff',
\                '--verify',
\                '--no-verify',
\                '--edit',
\                '--no-edit',
\                '--amend',
\                '--include',
\                '--only',
\                '--interactive',
\                '--dry-run',
\                '--reuse-message=',
\                '--reedit-message=',
\                '--reset-author',
\                '--file=',
\                '--message=',
\                '--template=',
\                '--cleanup=',
\                '--untracked-files',
\                '--untracked-files=',
\                '--verbose',
\                '--quiet',
\                '--fixup=',
\                '--squash=']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
