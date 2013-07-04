'use strict'

describe 'parse', (_)->

  it 'is a function', ->
    expect(parse instanceof Function).toBe true

  it 'honors precedence', ->
    expect(parse 'x \\ y & z | w').toEqual ['x','y','\\','z','&','w','|']
    expect(parse 'w | z & y \\ x').toEqual ['w','z','y','x','\\','&','|']

  it 'honors parentheses', ->
    expect(parse 'x \\ (y & (z | w))').toEqual ['x','y','z','w','|','&','\\']

  it 'throws on malformed input', ->
    try
      parse 'äää'
    catch error
      e = error
    finally
      expect(e).toBeDefined()
      expect(e instanceof Error).toBe true
      expect(e.message).toBe 'Malformed Input'

  it 'throws on mismatched left parentheses', ->
    try
      parse '((())'
    catch error
      e = error
    finally
      expect(e).toBeDefined()
      expect(e instanceof Error).toBe true
      expect(e.message).toBe 'Mismatched Parens'

  it 'throws on mismatched right parentheses', ->
    try
      parse '(()))'
    catch error
      e = error
    finally
      expect(e).toBeDefined()
      expect(e instanceof Error).toBe true
      expect(e.message).toBe 'Mismatched Parens'
