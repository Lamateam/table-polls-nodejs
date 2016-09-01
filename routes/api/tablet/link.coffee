exports.init = (app)->
  app.post "/api/v1/tablet/link", (req, res, next)->
    if req.body.key
      app.get('connector').tablets().link req.body.key, (err, result)->
        res.send { key: null }