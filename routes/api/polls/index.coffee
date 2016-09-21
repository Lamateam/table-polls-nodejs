async = require 'async'

exports.init = (app)->
  createPoll = (data, callback, next=null)->
    question = data.questions.pop()
    answers  = question.answers.join ', '

    app.get('connector').polls().create {
      question: question.text
      answers: answers
      success_text: data.success_text
      owner: data.owner
      start_date: data.start_date
      end_date: data.end_date
      next: next
      groups: data.groups
    }, (err, poll_id)->
      if err isnt null
        callback err
      else if data.questions.length isnt 0
        createPoll data, callback, poll_id
      else
        callback null
        
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
    
    createPoll req.body, (err)->
      if err isnt null
        res.status(400).send { message: err }
      else
        res.send req.body

  app.post "/api/v1/polls/active", (req, res, next)->
    app.get('connector').polls().active {
        is_active: req.body.is_active
        id: req.body.id
        owner: req.session.user.login
      }, (err, poll)->
        res.sendStatus 200

  app.put "/api/v1/polls", (req, res, next)->
    owner = req.session.user.login
    data  = req.body
    async.eachSeries data.questions, (question, callback)->
      answers = question.answers.join ', ' if typeof question.answers.join is 'function'

      app.get('connector').polls().update {
        question: question.text
        answers: answers
        success_text: data.success_text
        owner: owner
        start_date: data.start_date
        end_date: data.end_date
        id: question.id
        groups: data.groups        
      }, (err, poll)->
        console.log err if err
        callback()
    , ->
      res.sendStatus 200