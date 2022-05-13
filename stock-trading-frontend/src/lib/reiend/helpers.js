"use strict";

const toKebab = (word) => word.replace(/([a-z])([A-Z][a-z])/g, "$1-$2").toLowerCase();
const capitalize = (str) => str[0].toUpperCase() + str.slice(1);
const randomNumber = (limit) => Math.floor(Math.random() * limit);

const isFunctionInstance = (callback) => callback instanceof Function;
const isArrayInstance = (callback) => callback instanceof Array;
const isObjectInstance = (callback) => callback instanceof Object;

export {
  toKebab,
  capitalize,
  randomNumber,
  isFunctionInstance,
  isArrayInstance,
  isObjectInstance
};

