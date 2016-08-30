exports.init = (app)->
  app.get "/", (req, res, next)->
    res.redirect (if req.session.user then "/profile" else "/login")
  app.get '/profile', (req, res, next)->
    if req.session.user then res.render 'profile' else res.redirect '/login'
  app.get '/login', (req, res, next)->
    if !req.session.user then res.render 'login' else res.redirect '/profile'
  app.get '/confirm', (req, res, next)->
    app.get('connector').users().loginByTemp req.query.temp, (err, user)->
      req.session.user = user
      res.redirect '/'