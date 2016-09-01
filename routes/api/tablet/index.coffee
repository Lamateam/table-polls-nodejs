exports.init = (app)->
  app.get '/api/v1/tablet', (req, res, next)->
    app.get('connector').tablets().list { owner: req.session.user.login }, (err, tablets)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send { tablets: tablets }

  app.post "/api/v1/tablet", (req, res, next)->
    req.body.owner = req.session.user.login
    req.body.link  = Math.floor(Math.random() * (1000000 - 100000) + 100000)

    app.get('connector').tablets().create req.body, (err, tablet)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send { tablet: req.body }