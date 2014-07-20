keypress = require 'keypress'

Objects = require './objects'
Source = require './source'

objects = new Objects()

pipe = ->
  new Source(objects.show()).generate()

looop = ->
  setInterval pipe, 100

# now 'process.stdin' will start emiting 'keypress' events
keypress(process.stdin)

process.stdin.on 'keypress', (ch, key) ->
  if key['name'] == 'space'
    console.log key['name']
  else if key['name'] == 'left' or key['name'] == 'right'
    objects.move_paddle(key['name'])
  else
    process.exit()

process.stdin.setRawMode(true)
process.stdin.resume()

looop()
