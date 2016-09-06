exports.init = (app)->
  app.get '/api/v1/tabletanswers', (req, res, next)->
    app.get('connector').polls().list { owner: req.session.user.login }, (err, polls)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send { polls: polls }