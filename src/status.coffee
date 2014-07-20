class Status
  constructor: ->
    ###
    current game state : paused or not
    ###
    @state = false

    ###
    velocity vector for 'signal' object
    ###
    @dir =
      x: 0
      y: 0

    ###
    current position of 'signal' object
    ###
    @pos =
      line: 0
      row: 0

  set: ->
    @dir.y = -1
    if Math.floor(Math.random()*2) == 1
      @dir.x = 1
    else
      @dir.x = -1

module.exports = Status
