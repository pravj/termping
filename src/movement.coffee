class Movement
  constructor: (status, objects) ->
    @status = status
    @objects = objects

  revert: (vector) ->
    if vector == 1
      vector = -1
    else
      vector = 1

  paddle: (dir) ->
    if @status.state
      data = @objects.data
      h = data.length - 1
      w = data[1].length - 1

      # DUDE, YOU ARE SLEEPY BUT THIS THING NEEDS YOUR ATTENTION
      if dir == 'left'
        if data[h].indexOf('_▇▇▇▇▇▇▇▇▇▇') != -1
          data[h] = data[h].replace /_▇▇▇▇▇▇▇▇▇▇/, '▇▇▇▇▇▇▇▇▇▇_'
          @status.paddle.start -= 1
          @status.paddle.end = @status.paddle.start + 10
      else if dir == 'right'
        if data[h].indexOf('▇▇▇▇▇▇▇▇▇▇_') != -1
          data[h] = data[h].replace /▇▇▇▇▇▇▇▇▇▇_/, '_▇▇▇▇▇▇▇▇▇▇'
          @status.paddle.start += 1
          @status.paddle.end = @status.paddle.start + 10

  borderCollision: ->
    width = process.stdout.columns
    height = process.stdout.rows

    next =
      col: @status.current.col + @status.velocity.x
      row: @status.current.row + @status.velocity.y

    if next.col >= @status.paddle.start and next.col <= @status.paddle.end
      if next.row == height - 1
        @status.velocity.y = this.revert(@status.velocity.y)
    if next.col <= -1 or next.col >= width
      @status.velocity.x = this.revert(@status.velocity.x)
    if next.row >= height
      @status.velocity.y = this.revert(@status.velocity.y)
      process.exit()
    if next.row <= 0
      @status.velocity.y = this.revert(@status.velocity.y)

  traceback: ->
    row = @status.past.row
    col = @status.past.col
    data = @objects.data

    data[row] = data[row].substr(0, col) + ' ' + data[row].substr(col+1)

  signal: ->
    this.borderCollision()

    data = @objects.data
    sig = @objects.signal

    @status.past.col = @status.current.col
    @status.past.row = @status.current.row

    this.traceback()

    col = @status.current.col + @status.velocity.x
    row = @status.current.row + @status.velocity.y

    @status.current.col = col
    @status.current.row = row

    data[row] = data[row].substr(0, col) + sig + data[row].substr(col+1) 

module.exports = Movement
