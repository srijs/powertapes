'use strict'

Set = @Set

describe 'Set', (_)->

  it 'is an object', ->
    expect(Set instanceof Object).toEqual true

  describe 'cardinality', (_)->

    it 'is a function', ->
      expect(Set.cardinality instanceof Function).toEqual true

    it 'holds f({}) = 0', ->
      expect(Set.cardinality {}).toEqual 0

    it 'holds f({a}) = 1', ->
      expect(Set.cardinality {a:true}).toEqual 1

  describe 'empty', (_)->

    it 'is a function', ->
      expect(Set.empty instanceof Function).toEqual true

    it 'holds f({}) = true', ->
      expect(Set.empty {}).toEqual true

    it 'holds f({a}) = false', ->
      expect(Set.empty {a:true}).toEqual false

  describe 'intersection', (_)->

    it 'is a function', ->
      expect(Set.intersection instanceof Function).toEqual true

    it 'holds f({},{}) = {}', ->
      expect(Set.empty Set.intersection {}, {}).toEqual true

    it 'holds f({a},{a}) = {a}', ->
      inter = Set.intersection {a:true}, {a:true}
      expect(Set.cardinality inter).toEqual 1
      expect(inter.hasOwnProperty 'a').toEqual true

    it 'holds f({a},{b}) = {}', ->
      expect(Set.empty Set.intersection {a:true}, {b:true}).toEqual true

    it 'favors the first set', ->
      expect((Set.intersection {a:true}, {a:false}).a).toEqual true

  describe 'union', (_)->

    it 'is a function', ->
      expect(Set.union instanceof Function).toEqual true

    it 'holds f({},{}) = {}', ->
      expect(Set.empty Set.union {}, {}).toEqual true

    it 'holds f({a},{a}) = {a}', ->
      union = Set.union {a:true}, {a:true}
      expect(Set.cardinality union).toEqual 1
      expect(union.hasOwnProperty 'a').toEqual true

    it 'holds f({a},{b}) = {a,b}', ->
      union = Set.union {a:true}, {b:true}
      expect(Set.cardinality union).toEqual 2
      expect(union.hasOwnProperty 'a').toEqual true
      expect(union.hasOwnProperty 'b').toEqual true

    it 'favors the first set', ->
      expect((Set.union {a:true}, {a:false}).a).toEqual true

  describe 'difference', (_)->

    it 'is a function', ->
      expect(Set.difference instanceof Function).toEqual true

    it 'holds f({},{}) = {}', ->
      expect(Set.empty Set.difference {}, {}).toEqual true

    it 'holds f({a},{a}) = {}', ->
      expect(Set.empty Set.difference {a:true}, {a:true}).toEqual true

    it 'holds f({a},{b}) = {a}', ->
      diff = Set.difference {a:true}, {b:true}
      expect(Set.cardinality diff).toEqual 1
      expect(diff.hasOwnProperty 'a').toEqual true
