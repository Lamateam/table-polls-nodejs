exports.init = (app)->
  require("./static/main.coffee").init app
  require("./api/users/main.coffee").init app
  require("./api/tablet/main.coffee").init app
  require("./api/tabletanswers/main.coffee").init app
  require("./api/polls/main.coffee").init app
  require("./api/groups/index.coffee").init app
  require("./api/pictures/main.coffee").init app
    