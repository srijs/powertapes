'use strict'

inverse      = (f) -> (a) -> not f a
union        = (f, g) -> (a) -> (f or          g) a
intersection = (f, g) -> (a) -> (f and         g) a
difference   = (f, g) -> (a) -> (f and inverse g) a

params = !(stack, n, fn) ->
  if stack.length < n then throw new Error 'Incomplete Expression'
  else stack.push (fn.apply null, (stack.splice stack.length - n))

handle = (wrap, stack) -> !(r) -> switch r
  | \|  => params stack, 2, union
  | \&  => params stack, 2, intersection
  | \\\ => params stack, 2, difference
  | _   => stack.push wrap r

@compile = (wrap, rpn) ->
  rpn.forEach (handle wrap, stack = [])
  switch stack.length
  | 0 => null
  | 1 => stack.0
  | _ => throw new Error 'Incomplete Expression'
