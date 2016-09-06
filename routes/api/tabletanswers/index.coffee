exports.init = (app)->
  app.get '/api/v1/tabletanswers', (req, res, next)->
    app.get('connector').polls().list { owner: req.session.user.login, id: req.query.poll_id }, (err, polls)->
      if err isnt null
        res.status(400).send { message: err }
      else if polls.length is 0
        res.sendStatus 404
      else
        filters = { poll_id: req.query.poll_id }
        app.get('connector').tabletanswers().list filters, (err, answers)->
          if err isnt null
            res.status(400).send { message: err }
          else
            res.send { answers: answers }