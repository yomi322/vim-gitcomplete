let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#clone#complete(arglead, cmdline)
  if a:arglead =~# '^--'
    return copy(s:options)
  else
    return []
  endif
endfunction


let s:options = ['--local',
\                '--no-hardlinks',
\                '--shared',
\                '--reference',
\                '--quiet',
\                '--no-checkout',
\                '--bare',
\                '--mirror',
\                '--origin',
\                '--upload-pack',
\                '--template=',
\                '--depth',
\                '--single-branch',
\                '--branch']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
