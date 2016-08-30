exports.init = (app)->
  app.post "/api/v1/tablet/link", (req, res, next)->
    res.send if req.body.key  then { key: null } else { key: '239765' }