hash =
  '0': { url: '/static/images/happy.png', text: 'Отлично' }
  '1': { url: '/static/images/surprised.png', text: 'Сойдет' }
  '2': { url: '/static/images/confused.png', text: 'Не очень' }
  '3': { url: '/static/images/sad.png', text: 'Ужасно' }
exports.init = (app)->
  app.get "/api/v1/tablet/answer", (req, res, next)->
    res.send hash[req.query.id]