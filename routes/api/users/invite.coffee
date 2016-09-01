nodemailer  = require 'nodemailer'
transporter = nodemailer.createTransport 
  "host": "email-smtp.eu-west-1.amazonaws.com"
  "auth": 
    "user": "AKIAJJVMJQJROIWQBZPQ"
    "pass": "Ah/1M9OjiwEf8+Zbc1tKVP+6DO8G6T/4Vm/bfAj34CIZ"
      
exports.init = (app)->
  app.post "/api/v1/users/invite", (req, res, next)->
    if req.session.user and req.session.user.login is 'admin'
      app.get('connector').users().register { login: req.body.mail }, (err, user)->
        if err isnt null
          res.status(400).send { message: err }
        else
          res.send { link: "http://198.211.120.213:3001/confirm?temp=" + user.temp }
          # mailOptions = 
          #   from: "ses-smtp-user.20160830-122203@email-smtp.eu-west-1.amazonaws.com"
          #   to: user.login
          #   subject: "Приглашение в систему"
          #   text: "Перейди по ссылке http://198.211.120.213:3001/confirm?temp=" + user.temp + " чтобы завершить регистрацию."
          # transporter.sendMail mailOptions, (err, info)->
          #   console.log err
          #   res.send { link: "http://198.211.120.213:3001/confirm?temp=" + user.temp }
    else
      res.status(400).send { message: 'Вы не можете приглашать других пользователей в систему' }