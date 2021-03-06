class Objects
  constructor: (status) ->
    @status = status

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
    w = @data[1].length
    m = Math.floor(w/2) - 5

    @status.current.row = h - 1
    @status.current.col = m + 8

    @status.playerPaddle.start = m + 5
    @status.playerPaddle.end = m + 15

    @status.botPaddle.start = m + 5
    @status.botPaddle.end = m + 15

    @data[h-1] = @data[h-1].substr(0, m+8) + @signal + @data[h-1].substr(m+9)
    @data[1] = @data[1].substr(0, m+5) + @paddle + @data[1].substr(m+15)
    @data[0] = @data[0].replace /\s/g, '_'
    @data[h] = @data[h].substr(0, m+5) + @paddle + @data[h].substr(m+15)
    @data[h] = @data[h].replace /\s/g, '_'

module.exports = Objects
