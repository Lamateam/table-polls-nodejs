exports.init = (app)->
  require("./link.coffee").init app
  require("./poll.coffee").init app