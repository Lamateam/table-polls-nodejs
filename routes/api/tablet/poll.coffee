exports.init = (app)->
  app.get "/api/v1/tablet/poll", (req, res, next)->
    res.send 
      id: 'kdwqeofhqpfqwf'
      question: 'Ты получаешь этот опрос?'
      answers: [ '1', '2', 'lol' ]
      options: { }

  app.post "/api/v1/tablet/poll", (req, res, next)->
    res.sendStatus 200