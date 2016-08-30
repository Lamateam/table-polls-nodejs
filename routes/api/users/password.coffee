exports.init = (app)->
  app.post "/api/1.0/users/password", (req, res, next)->
    app.get('connector').users().setPassword req.session.user.login, req.body.password, (err)->
      if err isnt null
        res.status(400).send { message: err }
      else
        req.session.user.password = req.body.password
        res.sendStatus 200