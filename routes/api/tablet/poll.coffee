exports.init = (app)->
  app.get "/api/v1/tablet/poll", (req, res, next)->
    app.get('connector').polls().getActual req.query.tablet, (err, polls)->
      if err isnt null
        res.status(400).send { message: err }
      else
        if polls.length is 0
          res.sendStatus 404
        else
          poll = polls[0]
          poll.answers = poll.answers.split ', '
          res.send poll


  app.post "/api/v1/tablet/poll", (req, res, next)->
    req.body.answers = req.body.answers.join ', '
    app.get('connector').tabletanswers()
      .create { answers: req.body.answers, tablet_link: req.body.tablet, poll_id: req.body.id }, (err)->
        console.log err
        res.sendStatus 200