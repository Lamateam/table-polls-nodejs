nodemailer  = require 'nodemailer'
transporter = nodemailer.createTransport 
  "service": "gmail"
  "auth": 
    "user": "n.koroffin@gmail.com"
    "pass": "пока вырубаем почту - почему-то не приходят письма"
      
exports.init = (app)->
  app.post "/api/1.0/users/invite", (req, res, next)->
    if req.session.user and req.session.user.login is 'admin'
      app.get('connector').users().register { login: req.body.mail }, (err, user)->
        if err isnt null
          res.status(400).send { message: err }
        else
          mailOptions = 
            from: "n.koroffin@gmail.com"
            to: user.login
            subject: "Приглашение в систему"
            text: "Перейди по ссылке http://198.211.120.213:3000/confirm?temp=" + user.temp + " чтобы завершить регистрацию."
          transporter.sendMail mailOptions, (err, info)->
            res.sendStatus 200
    else
      res.status(400).send { message: 'Вы не можете приглашать других пользователей в систему' }