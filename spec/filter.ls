'use strict'

describe 'filter', (_)->

  it 'exports `compile`', ->
    expect(compile).toBeDefined!

  describe 'compile', (_)->
    wraps = {}

    beforeEach ->
      wraps.id = (a) -> a
      wraps.is = (is)
      wraps.isnt = (isnt)
      spyOn(wraps, 'id').andCallThrough!
      spyOn(wraps, 'is').andCallThrough!
      spyOn(wraps, 'isnt').andCallThrough!

    it 'is a function', ->
      expect(compile instanceof Function).toBe true

    it 'returns `null` when rpn is []', ->
      expect(compile wraps.id, []).toBe null

    it 'returns `wrap x` when rpn is [x]' ->
      expect(compile wraps.id, ['foo']).toBe 'foo'
      expect(wraps.id).toHaveBeenCalled!
      expect((compile wraps.is, [42]) instanceof Function).toBe true
      expect(wraps.is).toHaveBeenCalled!
      expect((compile wraps.is, [42]) 42).toBe true

    it 'returns a proper union' ->
      union = compile wraps.is, [1, 2, '|']
      expect(union instanceof Function).toBe true
      expect(wraps.is).toHaveBeenCalled!
      expect(union 1).toBe true
      expect(union 2).toBe true
      expect(union 3).toBe false

    it 'returns a proper intersection', ->
      inter = compile wraps.isnt, [1, 2, '&']
      expect(inter instanceof Function).toBe true
      expect(wraps.isnt).toHaveBeenCalled!
      expect(inter 1).toBe false
      expect(inter 2).toBe false
      expect(inter 3).toBe true

    it 'returns a proper difference', ->
      diff = compile wraps.id, [(<=4), (is 2), '\\']
      expect(diff instanceof Function).toBe true
      expect(wraps.id).toHaveBeenCalled!
      expect(diff 1).toBe true
      expect(diff 2).toBe false
      expect(diff 3).toBe true

    it 'throws on under-complete rpn', ->
      try
        compile wraps.id, [4, '&']
      catch error
        e = error
      finally
        expect(e).toBeDefined!
        expect(e.message).toBe 'Incomplete Expression'

    it 'throws on under-complete rpn', ->
      try
        compile wraps.id, [4, 4, 4, '&']
      catch error
        e = error
      finally
        expect(e).toBeDefined!
        expect(e.message).toBe 'Incomplete Expression'
