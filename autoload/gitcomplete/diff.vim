let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#diff#complete(arglead, cmdline)
  if gitcomplete#utils#has_arg(a:cmdline, '--')
    return vimshell#complete#helper#files(a:arglead)
  elseif a:arglead =~# '^--'
    return copy(s:options)
  else
    return gitcomplete#utils#revlist() +
    \      vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let s:options = ['--cached',
\                '--staged',
\                '--pickaxe-all',
\                '--pickaxe-regex',
\                '--base',
\                '--ours',
\                '--theirs',
\                '--no-index',
\                '--stat',
\                '--numstat',
\                '--shortstat',
\                '--summary',
\                '--patch-with-stat',
\                '--name-only',
\                '--name-status',
\                '--color',
\                '--no-color',
\                '--color-words',
\                '--no-renames',
\                '--check',
\                '--full-index',
\                '--binary',
\                '--abbrev',
\                '--diff-filter=',
\                '--find-copies-harder',
\                '--text',
\                '--ignore-space-at-eol',
\                '--ignore-space-change',
\                '--ignore-all-space',
\                '--exit-code',
\                '--quiet',
\                '--ext-diff',
\                '--no-ext-diff',
\                '--no-prefix',
\                '--src-prefix=',
\                '--dst-prefix=',
\                '--inter-hunk-context=',
\                '--patience',
\                '--raw',
\                '--dirstat',
\                '--dirstat=',
\                '--dirstat-by-file',
\                '--dirstat-by-file=',
\                '--cumulative']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
