'use strict';
const big = require("bignumber.js")
// number compare
exports.HNumber = function(obj) {
  return new big(new big(obj.toString()).dividedBy(1000000000000000000).toPrecision());
}
// display
exports.HShow = function(obj) {
  return new big(obj.toString()).dividedBy(1000000000000000000).toPrecision();
}
// base one
exports.HBase = function(num) {
  return new big(num).multipliedBy(BigInt(1000000000000000000));
}
