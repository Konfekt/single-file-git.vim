if &compatible || exists('g:loaded_git1')
    finish
endif

if !executable('git')
  finish
endif

" add directory of git1 to $PATH inside Vim
let s:script_path = fnamemodify(resolve(expand('<sfile>:p')), ':h')
let s:bin_path = fnamemodify(s:script_path . '/../bin', ':p')
if stridx($PATH, s:bin_path) < 0
	if has('win32')
		let $PATH .= ';' . s:bin_path
	else
		let $PATH .= ':' . s:bin_path
	endif
endif
unlet s:script_path
unlet s:bin_path

if !executable('git')
  finish
endif

let s:bang = has('nvim') ? 'term://' : '!'

if exists('g:loaded_fugitive')
  command! -complete=customlist,fugitive#Complete -nargs=+ G1 call s:git1(<q-args>)
  function! s:git1(args) abort
    let cmd = empty(a:args) ? 'status' : a:args
    if cmd ==# 'init' || cmd ==# 'deinit'
      exe s:bang . 'git1 ' . cmd
    else
      exe 'Git --git-dir=%:h:S/.g1_%:S --work-tree=%:h:S ' . cmd
    endif
  endfunction
else
  command! -complete=customlist,s:git1commands -nargs=+ G1 lcd %:h | exe s:bang . 'git1 %:S ' . <q-args>
  function! s:git1commands(arglead, cmdline, cursorpos)
    let targets = systemlist('git --list-cmds=builtins')
    return filter(targets, 'v:val =~? "^" . a:arglead')
  endfunction
endif

let g:loaded_git1 = 1
