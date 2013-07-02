(function (sandbox) {
  'use strict';

  var Set = {};

  Set.cardinality = function (a) {
    return Object.keys(a).length;
  };

  Set.intersection = function (a, b) {
    var o = {};
    Object.keys(a).forEach(function (key) {
      if (b.hasOwnProperty(key)) {
        o[key] = a[key];
      }
    });
    return o;
  };

  Set.union = function (a, b) {
    var o = {};
    Object.keys(b).forEach(function (key) { o[key] = b[key]; });
    Object.keys(a).forEach(function (key) { o[key] = a[key]; });
    return o;
  };

  Set.difference = function (a, b) {
    var o = {};
    Object.keys(a).forEach(function (key) {
      if (!b.hasOwnProperty(key)) {
        o[key] = a[key];
      }
    });
    return o;
  };

  sandbox.Set = Set;

}(this));
