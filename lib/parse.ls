'use strict'

prec = '\\':    3, '&':     2, '|':     1
lasc = '\\': true, '&':  true, '|':  true

handle = !(tok, output, stack) ->

  | prec[tok]? =>
    while top = stack[stack.length - 1]
      break unless lasc[tok] and prec[tok] == prec[top] or prec[tok] < prec[top]
      output.push stack.pop!
    stack.push tok

  | tok is \( => stack.push tok

  | tok is \) =>
    while not fin and top = stack.pop!
      if top is \( then fin = on
      else output.push top
    unless fin then throw new Error 'Mismatched Parens'

  | otherwise => output.push tok

@parse = (str, output = [], stack = []) ->

  while str = str.trim-left!
    if m = str.match /^([\|\&\\])|([\.\+\#\:]?[a-zA-Z0-9_\-]+)|([\(\)])/
      handle m[0], output, stack
      str = str.substr m[0].length
    else throw new Error 'Malformed Input'

  while top = stack.pop!
    if top in [\( \)] then throw new Error 'Mismatched Parens'
    output.push top

  output
