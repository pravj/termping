stream = require('stream').Readable

class Source
  constructor: (data) ->
    @data = data
    @source = new stream()

  generate: ->
    @source.push(@data)
    @source.push(null)
    @source.pipe(process.stdout)

module.exports = Source
