getChain = (polls, poll)->
  parent = findParent polls, poll.id
  while parent isnt null
    # Не показываем poll - он потомок в цепочке
    poll.inChain    = true
    # Пишем потомка в его родителя
    parent.child    = poll
    # Ищем родителя текущего родителя
    poll            = parent 
    parent          = findParent polls, poll.id
  return poll 
findParent = (polls, children_id)->
  for poll in polls 
    if poll.next is children_id
      return poll
  return null

exports.init = (app)->
  app.get "/", (req, res, next)->
    res.redirect (if req.session.user then "/profile" else "/login")

  app.get '/profile', (req, res, next)->   
    if req.session.user 
      app.get('connector').polls().list { owner: req.session.user.login }, (err, polls)->
        
        for poll in polls
            if !poll.inChain 
              getChain polls, poll

        res.render 'profile', { user: req.session.user, polls: polls } 
    else 
      res.redirect '/login'

  app.get '/login', (req, res, next)->
    if !req.session.user then res.render 'login' else res.redirect '/profile'

  app.get '/confirm', (req, res, next)->
    app.get('connector').users().loginByTemp req.query.temp, (err, user)->
      req.session.user = user
      res.redirect '/'