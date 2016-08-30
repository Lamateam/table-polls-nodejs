exports.init = (app)->
  require("./login.coffee").init app
  require("./logout.coffee").init app
  require("./invite.coffee").init app
  require("./password.coffee").init app