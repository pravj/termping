keypress = require 'keypress'

Movement = require './movement'
Objects = require './objects'
Source = require './source'
Status = require './status'

status = new Status()
status.set()
objects = new Objects(status)
movement = new Movement(status, objects)


class Game
  constructor: ->
    this.control()

  control: ->
    # now 'process.stdin' will start emiting 'keypress' events
    keypress(process.stdin)

    process.stdin.on 'keypress', (ch, key) ->
      if key['name'] == 'space'
        status.state = !(status.state)
      else if key['name'] == 'left' or key['name'] == 'right'
        movement.paddle(key['name'])
      else
        process.exit()

    process.stdin.setRawMode(true)
    process.stdin.resume()

  pipe: ->
    if status.state
      console.log `"\033c"`
      new Source(objects.show()).generate()

  signal: ->
    if status.state
      movement.signal()

  Loop: ->
    setInterval this.pipe, 100
    setInterval this.signal, 200

module.exports = Game
