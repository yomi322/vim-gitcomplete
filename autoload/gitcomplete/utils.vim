let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#utils#to_comp(list)
  return map(a:list, "{ 'word': v:val, 'menu': 'git' }")
endfunction


function! gitcomplete#utils#has_arg(cmdline, args)
  if type(a:args) == type([])
    let cmdline = a:cmdline[: -2]
    return len(filter(a:args, 'index(cmdline, v:val) >= 0')) > 0
  else
    return index(a:cmdline[: -2], a:args) >= 0
  endif
endfunction


function! gitcomplete#utils#get_gitdir()
  if isdirectory('.git')
    return '.git'
  endif
  let s = vimproc#system('git rev-parse --git-dir')
  return vimproc#get_last_status() == 0 ? split(s, '\n')[0] : ''
endfunction


function! gitcomplete#utils#heads()
  let s = vimproc#system(
  \         "git for-each-ref --format='%(refname:short)' refs/heads")
  return vimproc#get_last_status() == 0 ?
  \        gitcomplete#utils#to_comp(split(s, '\n')) : []
endfunction


function! gitcomplete#utils#refs()
  let gitdir = gitcomplete#utils#get_gitdir()
  let heads = filter(['HEAD', 'FETCH_HEAD', 'ORIG_HEAD', 'MERGE_HEAD'],
  \                  "filereadable(gitdir . '/' . v:val)")
  let s = vimproc#system(
  \         "git for-each-ref --format='%(refname:short)' " .
  \         "refs/tags refs/heads refs/remotes")
  let refs = vimproc#get_last_status() == 0 ? split(s, '\n') : []
  return gitcomplete#utils#to_comp(heads + refs)
endfunction


function! gitcomplete#utils#revlist()
  return gitcomplete#utils#refs()
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
