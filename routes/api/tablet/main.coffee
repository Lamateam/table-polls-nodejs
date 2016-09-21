exports.init = (app)->
  require("./link.coffee").init app
  require("./poll.coffee").init app
  require("./answer.coffee").init app
  require("./group.coffee").init app
  require("./index.coffee").init app