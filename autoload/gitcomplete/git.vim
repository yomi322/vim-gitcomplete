let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#git#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return copy(s:options)
  else
    return copy(s:commands)
  endif
endfunction


let s:options = ['--paginate',
\                '--no-pager',
\                '--git-dir=',
\                '--bare',
\                '--version',
\                '--exec-path',
\                '--exec-path=',
\                '--html-path',
\                '--info-path',
\                '--work-tree=',
\                '--namespace=',
\                '--no-replace-objects',
\                '--help']
let s:options = gitcomplete#utils#to_comp(s:options)

let s:commands = split(vimproc#system('git help -a'), '\n')
let s:commands = filter(s:commands, "v:val =~# '^  [A-Za-z0-9]'")
let s:commands = filter(split(join(s:commands)), "v:val !~# '--'")
let s:commands = gitcomplete#utils#to_comp(s:commands)


let &cpo = s:save_cpo
unlet s:save_cpo
