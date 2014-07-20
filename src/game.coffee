keypress = require 'keypress'

Objects = require './objects'

# now 'process.stdin' will start emiting 'keypress' events
keypress(process.stdin)

process.stdin.on 'keypress', (ch, key) ->
  if key['name'] == 'space'
    console.log key['name']
  else if key['name'] == 'left' or key['name'] == 'right'
    console.log key['name']
  else
    process.exit()

process.stdin.setRawMode(true)
process.stdin.resume()
