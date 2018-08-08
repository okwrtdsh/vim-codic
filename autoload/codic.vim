let s:save_cpo = &cpo
set cpo&vim

py3file <sfile>:h:h/codic.py
python3 import vim

function! codic#trans(text)
  python3 trans(vim.eval('a:text'))
endfunction

function! codic#trans_line(line)
  python3 vim.command("call setline('.', '%s')" % trans(vim.eval('a:line')))
endfunction

function! codic#trans_multi() range
  for l:n in range(a:firstline, a:lastline)
    let l:line = getline(l:n)
    python3 vim.command("call setline(l:n, '%s')" % trans(vim.eval('l:line')))
  endfor
endfunction

function! codic#trans_camel(text)
  python3 trans(vim.eval('a:text'), casing='camel')
endfunction

function! codic#trans_camel_line(line)
  python3 vim.command("call setline('.', '%s')" % trans(vim.eval('a:line'), casing='camel'))
endfunction

function! codic#trans_camel_multi() range
  for l:n in range(a:firstline, a:lastline)
    let l:line = getline(l:n)
    python3 vim.command("call setline(l:n, '%s')" % trans(vim.eval('l:line'), casing='camel'))
  endfor
endfunction

let &cpo = s:save_cpo
unlet s:save_cpo

