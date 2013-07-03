'use strict'

Set = @Set = {}

###*
 * Computes if the given object set is empty.
 * @param  {Object}  object set
 * @return {Boolean} true if the object set is empty
###
Set.empty = (a) ->
  (Object.keys a).length is 0

###*
 * Computes the cardinality of the given object set.
 * @param  {Object} object set
 * @return {Number} cardinality of the given set
###
Set.cardinality = (a) ->
  (Object.keys a).length

###*
 * Computes the intersection (A ∩ B) of two object sets.
 * @param  {Object}  object set A
 * @param  {Object}  object set B
 * @param  {?Object} target object
 * @return {Object}  intersection
###
Set.intersection = (a, b, o = {}) ->
  (Object.keys a).forEach (key) ->
    if b.hasOwnProperty key then o[key] = a[key]
  return o

###*
 * Computes the union (A ∪ B) of two object sets.
 * @param  {Object}  object set A
 * @param  {Object}  object set B
 * @param  {?Object} target object
 * @return {Object}  union
###
Set.union = (a, b, o = {}) ->
  (Object.keys b).forEach (key) -> o[key] = b[key]
  (Object.keys a).forEach (key) -> o[key] = a[key]
  return o

###*
 * Computes the difference (A \ B) of two object sets.
 * @param  {Object}  object set A
 * @param  {Object}  object set B
 * @param  {?Object} target object
 * @return {Object}  difference
###
Set.difference = (a, b, o = {}) ->
  (Object.keys a).forEach (key) ->
    unless b.hasOwnProperty key then o[key] = a[key]
  return o
