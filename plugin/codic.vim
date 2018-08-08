if exists("g:loaded_vim_codic")
  finish
endif
let g:loaded_vim_codic = 1

let s:save_cpo = &cpo
set cpo&vim

command! -nargs=1 Codic call codic#trans(<f-args>)
command! -nargs=0 Codic call codic#trans_line(getline("."))
command! -range Codic <line1>,<line2>call codic#trans_multi()
command! -nargs=1 CodicCamel call codic#trans_camel(<f-args>)
command! -nargs=0 CodicCamel call codic#trans_camel_line(getline("."))
command! -range CodicCamel <line1>,<line2>call codic#trans_camel_multi()

let &cpo = s:save_cpo
unlet s:save_cpo

