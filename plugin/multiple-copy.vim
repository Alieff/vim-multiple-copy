" ----------------------------------------------------
" workaround to copy & paste in terryma multiple cursor
function! AppendToRegister(str)
  let newRegValue = @z . g:custom_pop_register_delimiter . a:str
  " let newRegValue = substitute(newRegValue,'^\n','','g') "remove first newline
  let @z = newRegValue
  let @x = ""
  let temp = split(@z, g:custom_pop_register_delimiter ) 
  echo 'appended to register z('.len(temp).')'
endfunction 

" ----------------------------------------------------
function! CycleForwardRegisterZ()
  let pasteData = split(@z, g:custom_pop_register_delimiter ) 
  if len(pasteData) == 0
    echom 'register z empty'
    return
  endif
  let poppedData = pasteData[0]
  let remainingData = pasteData[1:]
  let pasteData = join(remainingData, g:custom_pop_register_delimiter)
  " below we put aggain the popped data, so it is always circular
  let @z = pasteData . g:custom_pop_register_delimiter . poppedData
  let nextPoppedData = split(@z, g:custom_pop_register_delimiter )[0]
  echom nextPoppedData
endfunction 

function! CycleBackwardRegisterZ()
  let pasteData = split(@z, g:custom_pop_register_delimiter ) 
  if len(pasteData) == 0
    echom 'register z empty'
    return
  endif
  let poppedData = pasteData[-1]
  let remainingData = pasteData[:-2]
  let pasteData = join(remainingData, g:custom_pop_register_delimiter)
  " below we put aggain the popped data, so it is always circular
  let @z = poppedData . g:custom_pop_register_delimiter . pasteData
  echom poppedData
endfunction 



" ----------------------------------------------------
let g:custom_pop_register_delimiter = '±' " '±' = alt+1
" workaround to copy & paste in terryma multiple cursor
function! PopRegisterZ(mode)
  let pasteData = split(@z, g:custom_pop_register_delimiter ) 

  if len(pasteData) == 0
    " if a:mode == "pop"
    "   let temp = @0
    "   let @0=""
    "   return temp
    " endif
    " return @0
    return ""
  endif

  let poppedData = pasteData[0]
  if a:mode == "pop"
    let remainingData = pasteData[1:]
    let pasteData = join(remainingData, g:custom_pop_register_delimiter)
    " below we put aggain the popped data, so it is always circular
    let @z = pasteData . g:custom_pop_register_delimiter . poppedData
  else
    let remainingData = pasteData
    let pasteData = join(remainingData, g:custom_pop_register_delimiter)
  endif
  let @" = poppedData
  return poppedData
endfunction
" :command! -range -nargs=* PopRegisterZ call s:PopRegisterZ(<f-args>)

":command! AppendToRegister call s:appendToRegister()
vnoremap <a-c> "hy:call AppendToRegister(@h)<cr>
vnoremap <a-x> "hx:call AppendToRegister(@h)<cr>
nnoremap <a-z> :let @z=""<bar>echo 'register z cleared: 0'<cr>
vnoremap <a-z> <esc>:let @z=""<bar>echo 'register z cleared: 0'<cr>gv


" pop register z
vnoremap <a-o> "0d:let temp = &autoindent<cr>:set noautoindent<cr>i<c-r>=PopRegisterZ('unpop')<cr><esc>l:let &autoindent = temp<cr>
vnoremap <a-s-o> "0d:let temp = &autoindent<cr>:set noautoindent<cr>i<c-r>=PopRegisterZ('pop')<cr><esc>l:let &autoindent = temp<cr>
inoremap <a-o> <c-r>=PopRegisterZ('unpop')<cr>
inoremap <a-s-o> <c-r>=PopRegisterZ('pop')<cr>
nnoremap <a-o> :let temp = &paste<cr>:set paste<cr>i<c-r>=PopRegisterZ('unpop')<cr><esc>:let &paste = temp<cr>
nnoremap <a-s-o> :let temp = &paste<cr>:set paste<cr>i<c-r>=PopRegisterZ('pop')<cr><esc>:let &paste = temp<cr>

" cyccle register
nnoremap <a-d> :call CycleForwardRegisterZ()<cr>
nnoremap <a-a> :call CycleBackwardRegisterZ()<cr>
inoremap <a-d> <c-o>:call CycleForwardRegisterZ()<cr>
inoremap <a-a> <c-o>:call CycleBackwardRegisterZ()<cr>
vnoremap <a-d> :call CycleForwardRegisterZ()<cr>
vnoremap <a-a> :call CycleBackwardRegisterZ()<cr>
