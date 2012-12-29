let s:save_cpo = &cpo
set cpo&vim


let s:command = { 'name': 'git',
\                 'kind': 'internal',
\                 'description': 'git [{options}...] {command} [{args}...]' }

function! vimshell#commands#git#define()
  return s:command
endfunction

function! s:command.execute(args, context)
  return vimshell#execute_internal_command('exe', ['git'] + a:args, a:context)
endfunction

function! s:command.complete(args)
  let arglead = a:args[-1]
  let cmdline = a:args
  return vimshell#complete#helper#keyword_filter(
  \        gitcomplete#complete(arglead, cmdline), arglead)
endfunction


let &cpo = s:save_cpo
unlet s:save_cpo
