(function (sandbox) {
  'use strict';

  var Set = sandbox.Set;

  describe('Set', function () {

    it('is an object', function () {
      expect(Set instanceof Object).toBeTruthy();
    });

    describe('cardinality', function () {

      it('is a function', function () {
        expect(Set.cardinality instanceof Function).toBeTruthy();
      });

      it('holds f({}) = 0', function () {
        expect(Set.cardinality({})).toEqual(0);
      });

      it('holds f({a}) = 1', function () {
        expect(Set.cardinality({a:true})).toEqual(1);
      });

    });

    describe('intersection', function () {

      it('is a function', function () {
        expect(Set.intersection instanceof Function).toBeTruthy();
      });

      it('holds f({}, {}) = {}', function () {
        expect(Set.cardinality(Set.intersection({}, {}))).toEqual(0);
      });

      it('holds f({a}, {a}) = {a}', function () {
        var inter = Set.intersection({a:true}, {a:true});
        expect(Set.cardinality(inter)).toEqual(1);
        expect(inter.hasOwnProperty('a')).toBeTruthy();
      });

      it('holds f({a}, {b}) = {}', function () {
        expect(Set.cardinality(Set.intersection({a:true}, {b:true}))).toEqual(0);
      });

      it('favors the first set', function () {
        expect(Set.intersection({a:true}, {a:false}).a).toEqual(true);
      });

    });

    describe('union', function () {

      it('is a function', function () {
        expect(Set.union instanceof Function).toBeTruthy();
      });

      it('holds f({}, {}) = {}', function () {
        expect(Set.cardinality(Set.union({}, {}))).toEqual(0);
      });

      it('holds f({a}, {a}) = {a}', function () {
        var union = Set.union({a:true}, {a:true});
        expect(Set.cardinality(union)).toEqual(1);
        expect(union.hasOwnProperty('a')).toBeTruthy();
      });

      it('holds f({a}, {b}) = {a, b}', function () {
        var union = Set.union({a:true}, {b:true});
        expect(Set.cardinality(union)).toEqual(2);
        expect(union.hasOwnProperty('a')).toBeTruthy();
        expect(union.hasOwnProperty('b')).toBeTruthy();
      });

      it('favors the first set', function () {
        expect(Set.union({a:true}, {a:false}).a).toEqual(true);
      });

    });

    describe('difference', function () {

      it('is a function', function () {
        expect(Set.difference instanceof Function).toBeTruthy();
      });

      it('holds f({}, {}) = {}', function () {
        expect(Set.cardinality(Set.difference({}, {}))).toEqual(0);
      });

      it('holds f({a}, {a}) = {}', function () {
        expect(Set.cardinality(Set.difference({a:true}, {a:true}))).toEqual(0);
      });

      it('holds f({a}, {b}) = {a}', function () {
        var diff = Set.difference({a:true}, {b:true});
        expect(Set.cardinality(diff)).toEqual(1);
        expect(diff.hasOwnProperty('a')).toBeTruthy();
      });
    });

  });

}(this));
