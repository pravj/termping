class Movement
  constructor: (status, objects) ->
    @status = status
    @objects = objects

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

module.exports = Movement
