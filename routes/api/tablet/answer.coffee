hash =
  '0': { url: '/static/images/happy.png', text: 'Отлично' }
  '1': { url: '/static/images/surprised.png', text: 'Сойдет' }
  '2': { url: '/static/images/confused.png', text: 'Не очень' }
  '3': { url: '/static/images/sad.png', text: 'Ужасно' }
  '4': { url: '/static/images/sad.png', text: 'Pilnībā apmierināts/ -a' }
  '5': { url: '/static/images/sad.png', text: 'Drīzāk apmierināts/ -a' }
  '6': { url: '/static/images/sad.png', text: 'Drīzāk neapmierināts/ -a' }
  '7': { url: '/static/images/sad.png', text: 'Pilnībā neapmierināts/ -a' }
exports.init = (app)->
  app.get "/api/v1/tablet/answer", (req, res, next)->
    console.log 'here recieve answer: ', req.query.id, hash[req.query.id]
    res.send hash[req.query.id]