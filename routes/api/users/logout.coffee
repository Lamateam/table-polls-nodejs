exports.init = (app)->
  app.post "/api/v1/users/logout", (req, res, next)->
    req.session.user = null
    res.sendStatus 200