class Movement
  constructor: (status, objects) ->
    @status = status
    @objects = objects

    @data = objects.data

    @paddle =
      start: status.paddle.start
      end: status.paddle.end

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
          @paddle.start -= 1
          @paddle.end = @paddle.start + 10
      else if dir == 'right'
        if @data[h].indexOf('▇_') != -1
          @data[h] = @data[h].replace /▇▇▇▇▇▇▇▇▇▇_/, '_▇▇▇▇▇▇▇▇▇▇'
          @paddle.start += 1
          @paddle.end = @paddle.start + 10

  collision: ->
    width = process.stdout.columns
    height = process.stdout.rows

    next =
      col: @current.col + @velocity.x
      row: @current.row + @velocity.y

    if @current.col >= @paddle.start and @current.col <= @paddle.end
      if next.row == height - 1
        @velocity.y = this.revert(@velocity.y)
    if next.col <= -1 or next.col >= width
      @velocity.x = this.revert(@velocity.x)
    if next.row >= height
      @velocity.y = this.revert(@velocity.y)
      process.exit()
    if next.row <= 0
      @velocity.y = this.revert(@velocity.y)

  traceback: ->
    c = @past.col
    r = @past.row

    @data[r] = @data[r].substr(0, c) + ' ' + @data[r].substr(c+1)

  move_signal: ->
    this.collision()

    sig = @objects.signal

    @past.col = @current.col
    @past.row = @current.row

    this.traceback()

    c = @current.col + @velocity.x
    r = @current.row + @velocity.y

    @current.col = c
    @current.row = r

    @data[r] = @data[r].substr(0, c) + sig + @data[r].substr(c+1) 

module.exports = Movement
