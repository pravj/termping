#
# Cakefile to build in '/lib' from '/src'
#
# taken from example in the book ->
# 'The Little Book on CoffeeScript'
#

fs = require 'fs'

{print} = require 'util'
{spawn} = require 'child_process'

build = (callback) ->
  coffee = spawn 'coffee', ['-c', '-o', 'lib', 'src']

  coffee.stderr.on 'data', (data) ->
    process.stderr.write data.toString()

  coffee.stdout.on 'data', (data) ->
    print data.toString()

  coffee.on 'exit', (code) ->
    callback?() if code is 0

task 'build', 'Build in lib/ from src/', ->
  build()
