class Status
  constructor: ->

    ###
    current game state : paused or not
    ###
    @state = false

    ###
    velocity vector for 'signal' object
    ###
    @velocity =
      x: 0
      y: 0

    ###
    current position of 'signal' object
    ###
    @current =
      col: 0
      row: 0

    ###
    past position of 'signal' object
    ###
    @past =
      col: 0
      row: 0

    ###
    current position of Player's paddle
    ###
    @playerPaddle =
      start: 0
      end: 0

    ###
    current position of Computer's paddle
    ###
    @botPaddle =
      start: 0
      end: 0

  set: ->
    @velocity.x = -1
    @velocity.y = -1

    if Math.floor(Math.random()*2) == 1
      @velocity.x = 1

module.exports = Status
