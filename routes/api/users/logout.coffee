exports.init = (app)->
  app.post "/api/1.0/users/logout", (req, res, next)->
    req.session.user = null
    res.sendStatus 200