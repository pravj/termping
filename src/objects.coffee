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
    this.addBlocks()

  plot: ->
    h = @data.length - 1
    w = @data[1].length
    m = Math.floor(w/2) - 5

    @status.current.row = h - 1
    @status.current.col = m + 8

    @status.paddle.start = m + 8
    @status.paddle.end = m + 18

    @data[h-1] = @data[h-1].substr(0, m+8) + @signal + @data[h-1].substr(m+9)
    @data[h] = @data[h].substr(0, m+5) + @paddle + @data[h].substr(m+15)
    @data[h] = @data[h].replace /\s/g, '_'
    @data[0] = @data[0].replace /\s/g, '_'

  addBlocks: ->
    if process.stdout.rows < 11
      console.log 'terminal dimension is too little.'
      process.exit()

    extreme = process.stdout.columns
    for i in [3...10]
      @data[i] = @data[i].substr(0, i+5)
      for j in [i+5...extreme-i-5]
        @data[i] += @signal
      @data[i] += "\n"
      

module.exports = Objects
