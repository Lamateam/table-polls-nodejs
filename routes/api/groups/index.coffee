async = require 'async'

exports.init = (app)->
  app.get '/api/v1/groups', (req, res, next)->
    app.get('connector').groups().list { owner: req.session.user.login }, (err, groups)->
      if err isnt null
        res.status(400).send { message: err }
      else 
        res.send { groups: groups }

  app.post '/api/v1/groups', (req, res, next)->
    owner = req.session.user.login

    app.get('connector').groups().create { owner: req.session.user.login, name: req.body.name }, (err, ids)->
      if err isnt null
        res.status(400).send { message: err }
      else 
        id = ids[0]
        async.eachSeries req.body.tablets, (tablet_link, callback)->
          app.get('connector').tabletgroups().create { tablet_link: tablet_link, group_id: id }, (err)->
            console.log err if err
            callback()
        , ->
          res.send 200