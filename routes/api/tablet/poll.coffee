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
          console.log 'here recieve poll: ', poll
          res.send poll

  app.get "/api/v1.1/tablet/poll", (req, res, next)->
    app.get('connector').polls().getActual req.query.tablet, (err, polls)->
      if err isnt null
        res.status(400).send { message: err }
      else
        if polls.length is 0
          res.sendStatus 404
        else
          for poll in polls
            poll.answers = poll.answers.split ', '

            for answer, i in poll.answers 
              poll.answers[i] = JSON.parse(answer) if answer.length > 2

          console.log 'here recieve poll: ', polls
          res.send { data: polls }


  app.post "/api/v1/tablet/poll", (req, res, next)->
    for answers in req.body.answers
      raw_answers = answers.answer.join ', '
      obj = 
        answers: raw_answers
        tablet_link: req.body.tablet
        poll_id: answers.id
        person_male: req.body.person_male
        person_smile: req.body.person_smile
        person_age: req.body.person_age
      app.get('connector').tabletanswers()
        .create obj, (err)->
          console.log err if err
    res.sendStatus 200

  app.post "/api/v1.1/tablet/poll", (req, res, next)->
    req.body.answers = req.body.answers.join ', '
    obj = 
      answers: req.body.answers
      tablet_link: req.body.tablet
      poll_id: req.body.id
      person_male: req.body.person_male
      person_smile: req.body.person_smile
      person_age: req.body.person_age
    app.get('connector').tabletanswers()
      .create obj, (err)->
        console.log err
        res.sendStatus 200