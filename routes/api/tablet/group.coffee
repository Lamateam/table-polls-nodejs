exports.init = (app)->
  app.post "/api/v1/tablet/group", (req, res, next)->
    app.get('connector').groups().link req.body, (err, tablet)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.sendStatus 200