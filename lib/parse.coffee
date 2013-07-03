'use strict'

prec = '\\':    3, '&':     2, '|':     1
lasc = '\\': true, '&':  true, '|':  true

handle = (tok, stack, output) ->
  
  if prec[tok]?
    while top = stack[stack.length - 1]
      break unless lasc[tok] and prec[tok] == prec[top] or prec[tok] < prec[top]
      output.push stack.pop null
    stack.push tok
 
  else if tok is '('
    stack.push tok
  
  else if tok is ')'
    while not fin and top = stack[stack.length - 1]
      if top is '(' then fin = on
      else output.push stack.pop null
    if not fin then throw new Error 'Mismatched Parens'
    stack.pop null

  else output.push tok

@parse = (str, stack = [], output = []) ->
  
  while str = str.trimLeft null
    if m = str.match /^([\|\&\\])|([\.\+\#\:]?[a-zA-Z0-9_\-]+)|([\(\)])/
      handle m[0], stack, output
      str = str.substr m[0].length
    else throw new Error 'Malformed Input'

  while top = stack.pop null
    if top in ['(', ')'] then throw new Error 'Mismatched Parens'
    output.push top

  output
