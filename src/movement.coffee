class Movement
  constructor: (status, objects) ->
    @status = status
    @objects = objects

    @data = objects.data

    @width = process.stdout.columns
    @height = process.stdout.rows

    @paddleP =
      start: status.playerPaddle.start
      end: status.playerPaddle.end
    @paddleB =
      start: status.botPaddle.start
      end: status.botPaddle.end

    @velocity =
      x: status.velocity.x
      y: status.velocity.y

    @current =
      col: status.current.col
      row: status.current.row
    @past =
      col: status.past.col
      row: status.past.row

  revert: (vector) ->
    if vector == 1
      vector = -1
    else
      vector = 1

  move_paddle: (dir) ->
    if @status.state
      h = @data.length - 1
      w = @data[1].length - 1

      if dir == 'left'
        if @data[h].indexOf('_▇') != -1
          @data[h] = @data[h].replace /_▇▇▇▇▇▇▇▇▇▇/, '▇▇▇▇▇▇▇▇▇▇_'
          @paddleP.start -= 1
          @paddleP.end -= 1
      else if dir == 'right'
        if @data[h].indexOf('▇_') != -1
          @data[h] = @data[h].replace /▇▇▇▇▇▇▇▇▇▇_/, '_▇▇▇▇▇▇▇▇▇▇'
          @paddleP.start += 1
          @paddleP.end += 1

  collision_player: ->
    next =
      col: @current.col + @velocity.x
      row: @current.row + @velocity.y

    if @current.col >= @paddleP.start and @current.col <= @paddleP.end
      if next.row == @height - 1
        @velocity.y = this.revert(@velocity.y)

  collision_computer: ->
    next =
      col: @current.col + @velocity.x
      row: @current.row + @velocity.y
   
    if @current.col >= @paddleB.start and @current.col <= @paddleB.end
      if @current.row == 2
        @velocity.y = this.revert(@velocity.y)
    
  collision_border: ->
    next =
      col: @current.col + @velocity.x
      row: @current.row + @velocity.y

    if next.col <= -1 or next.col >= @width
      @velocity.x = this.revert(@velocity.x)
    if @current.row <= 0
      @velocity.y = this.revert(@velocity.y)
      process.exit()
    if next.row >= @height
      @velocity.y = this.revert(@velocity.y)
      process.exit()

  move_computer: ->
    if @current.col <= @paddleB.start
      @data[1] = @data[1].replace ' ▇▇▇▇▇▇▇▇▇▇', '▇▇▇▇▇▇▇▇▇▇ '
      @paddleB.start -= 1
      @paddleB.end -= 1
    else if @current.col >= @paddleB.end
      @data[1] = @data[1].replace '▇▇▇▇▇▇▇▇▇▇ ', ' ▇▇▇▇▇▇▇▇▇▇'
      @paddleB.start += 1
      @paddleB.end += 1

  traceback: ->
    c = @past.col
    r = @past.row

    @data[r] = @data[r].substr(0, c) + ' ' + @data[r].substr(c+1)

  move_signal: ->
    this.collision_player()
    this.collision_computer()
    this.collision_border()

    @past.col = @current.col
    @past.row = @current.row

    this.traceback()

    c = @current.col + @velocity.x
    r = @current.row + @velocity.y

    @current.col = c
    @current.row = r

    @data[r] = @data[r].substr(0, c) + @objects.signal + @data[r].substr(c+1)

module.exports = Movement
