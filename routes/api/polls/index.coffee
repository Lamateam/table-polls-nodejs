exports.init = (app)->
  app.get '/api/v1/polls', (req, res, next)->
    if req.query.tablet_link is undefined
      app.get('connector').polls().list { owner: req.session.user.login }, (err, polls)->
        if err isnt null
          res.status(400).send { message: err }
        else
          res.send { polls: polls }
    else
      app.get('connector').polls().listByTablet { tablet_link: req.query.tablet_link, owner: req.session.user.login }, (err, polls)->
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

  app.put "/api/v1/polls", (req, res, next)->
    req.body.owner = req.session.user.login

    app.get('connector').polls().update req.body, (err, poll)->
      console.log err
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send req.body