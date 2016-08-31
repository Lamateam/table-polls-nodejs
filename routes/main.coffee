exports.init = (app)->
  require("./static/main.coffee").init app
  require("./api/users/main.coffee").init app
  require("./api/tablet/main.coffee").init app

    