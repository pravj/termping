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
      paddleStart = data[h].indexOf(@objects.signal)

      if paddleStart > 0 or paddleStart < w
        if dir == 'left'
          data[h] = data[h].replace /_▇▇▇▇▇▇▇▇▇▇/, '▇▇▇▇▇▇▇▇▇▇_'
        else if dir == 'right'
          data[h] = data[h].replace /▇▇▇▇▇▇▇▇▇▇_/, '_▇▇▇▇▇▇▇▇▇▇'

  collision: ->
    width = process.stdout.columns
    height = process.stdout.rows

    next =
      col: @status.current.col + @status.velocity.x
      row: @status.current.row + @status.velocity.y

    if next.col <= -1 or next.col >= width
      @status.velocity.x = this.revert(@status.velocity.x)
    if next.row <= 0 or next.row >= height
      console.log @status.velocity.y
      @status.velocity.y = this.revert(@status.velocity.y)
      console.log @status.velocity.y

  signal: ->
    this.collision()

    data = @objects.data
    sig = @objects.signal

    col = @status.current.col + @status.velocity.x
    row = @status.current.row + @status.velocity.y

    @status.current.col = col
    @status.current.row = row

    data[row] = data[row].substr(0, col) + sig + data[row].substr(col+1) 

module.exports = Movement