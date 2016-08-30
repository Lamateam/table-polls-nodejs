exports.init = (app)->
  app.post "/api/1.0/users/login", (req, res, next)->
    app.get('connector').users().login req.body.login, req.body.password, (err, user)->
      if err isnt null
        res.status(400).send { message: err }
      else
        req.session.user = user
        res.sendStatus 200