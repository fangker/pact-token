'use strict'
const merge = require('webpack-merge')
const prodEnv = require('./prod.env')

module.exports = merge(prodEnv, {
  URL: "http://localhost:8080/",
  NODE_ENV: '"development"',
  network: '"development"',
  HOST: "",
  PORT: "80"
})
