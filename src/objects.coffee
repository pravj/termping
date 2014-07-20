class Objects
  constructor: ->
    @signal = '▇'
    @paddle = '▇▇▇▇▇▇▇▇▇▇'

    @data = []
    this.populate(process.stdout.columns, process.stdout.rows)

  show: ->
    @data.join('')

  populate: (width, height) ->
    for i in [0...height]
      @data[i] = ''
      for j in [0...width-1]
        @data[i] += ' '
      @data[i] += "\n"

    this.plot()

  plot: ->
    h = @data.length - 1
    w = @data[0].length
    m = Math.floor(w/2) - 5

    @data[h] = @data[h].substr(0, m+5) + @paddle + @data[h].substr(m+15)
    @data[h] = @data[h].replace /\s/g, '_'
    @data[0] = @data[0].replace /\s/g, '_'

  move_paddle: (dir) ->
    h = @data.length - 1

    if dir == 'left'
      @data[h] = @data[h].replace /_▇▇▇▇▇▇▇▇▇▇/, '▇▇▇▇▇▇▇▇▇▇_'
    else if dir == 'right'
      @data[h] = @data[h].replace /▇▇▇▇▇▇▇▇▇▇_/, '_▇▇▇▇▇▇▇▇▇▇'

module.exports = Objects
