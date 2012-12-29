let s:save_cpo = &cpo
set cpo&vim


function! gitcomplete#log#complete(arglead, cmdline)
  if gitcomplete#utils#has_arg(a:cmdline, '--')
    return vimshell#complete#helper#files(a:arglead)
  elseif a:arglead =~# '^--pretty=\|^--format='
    let o = matchstr(a:arglead, '\zs.\+=\ze')
    return gitcomplete#utils#to_comp(
    \        map(['oneline', 'short', 'medium', 'full', 'fuller',
    \              'email', 'raw', 'format:'],
    \            'o . v:val.word'))
  elseif a:arglead =~# '^--date='
    return gitcomplete#utils#to_comp(
    \        map(['relative', 'iso8601', 'rfc2822', 'short', 'local',
    \              'default', 'raw'],
    \            "'--date=' . v:val"))
  elseif a:arglead =~# '^--decorate='
    return gitcomplete#utils#to_comp(
    \        map(['long', 'short'], "'--decorate=' . v:val"))
  elseif a:arglead =~# '^--'
    let gitdir = gitcomplete#utils#get_gitdir()
    let merge = filereadable(gitdir . '/MERGE_HEAD') ?
    \             gitcomplete#utils#to_comp(['--merge']) : []
    return copy(s:options) + merge
  else
    return gitcomplete#utils#revlist() +
    \      vimshell#complete#helper#files(a:arglead)
  endif
endfunction


let s:options = ['--not',
\                '--all',
\                '--branches',
\                '--tags',
\                '--remotes',
\                '--first-parent',
\                '--merges',
\                '--no-merges',
\                '--max-count=',
\                '--max-age=',
\                '--since=',
\                '--after=',
\                '--min-age=',
\                '--until=',
\                '--before=',
\                '--min-parents=',
\                '--max-parents=',
\                '--no-min-parents',
\                '--no-max-parents',
\                '--author=',
\                '--committer=',
\                '--grep=',
\                '--all-match',
\                '--root',
\                '--topo-order',
\                '--date-order',
\                '--reverse',
\                '--follow',
\                '--full-diff',
\                '--abbrev-commit',
\                '--abbrev=',
\                '--relative-date',
\                '--date=',
\                '--pretty=',
\                '--format=',
\                '--oneline',
\                '--cherry-pick',
\                '--graph',
\                '--decorate',
\                '--decorate=',
\                '--walk-reflogs',
\                '--parents',
\                '--children',
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
\                '--cumulative',
\                '--pickaxe-all',
\                '--pickaxe-regex']
let s:options = gitcomplete#utils#to_comp(s:options)


let &cpo = s:save_cpo
unlet s:save_cpo
