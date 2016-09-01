exports.init = (app)->
  app.get '/api/v1/polls', (req, res, next)->
    app.get('connector').polls().list { owner: req.session.user.login }, (err, polls)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send { polls: polls }

  app.post "/api/v1/polls", (req, res, next)->
    req.body.owner   = req.session.user.login
    req.body.answers = req.body.answers.join ', '

    app.get('connector').polls().create req.body, (err, poll)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send { }