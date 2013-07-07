'use strict'

const p = \\\ :3   \& :2   \| :1
const l = \\\ :yes \& :yes \| :yes

handle = !(tok, output, stack) ->

  | p[tok]? =>
    while (top = stack.pop!) and l[tok] and p[tok] == p[top] or p[tok] < p[top]
      output.push top
    stack.push top, tok

  | tok is \( => stack.push tok

  | tok is \) =>
    while (top = stack.pop!) and top isnt \(
      output.push top
    if top isnt \( then throw new Error 'Mismatched Parens'

  | otherwise => output.push tok

@parse = (str, output = [], stack = []) ->

  while str = str.trim-left!
    if m = str.match /^([\|\&\\])|([\.\+\#\:]?[a-zA-Z0-9_\-\/]+)|([\(\)])/
      handle m.0, output, stack
      str .= substr m.0.length
    else throw new Error 'Malformed Input'

  while top = stack.pop!
    if top in <[( )]> then throw new Error 'Mismatched Parens'
    output.push top

  output
