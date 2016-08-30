crypto         = require 'crypto'

AbstractSchema = require './abstract.coffee'

class UsersSchema extends AbstractSchema
  name: "users"
  initTable: (table, callback)->
    table.string("login").unique().collate "utf8_general_ci"
    table.string("password").collate "utf8_general_ci"
    table.string("salt").collate "utf8_general_ci"
    table.string("temp").collate "utf8_general_ci"

    callback()
  register: (data, callback)->
    data.temp       = Math.round((new Date().valueOf() * Math.random())) + ''
    data.created_at = new Date()
    data.updated_at = new Date()
    @knex("users")
      .insert data
      .then -> callback(null, data)
      .catch (err)->
        callback "Ошибка при регистрации нового пользователя. Может быть этот e-mail уже занят?"
        console.error "Error in Users schema! Method 'register':\n", err
  setPassword: (login, password, callback)->
    data = { }
    data.salt = Math.round((new Date().valueOf() * Math.random())) + ''
    data.password = crypto.createHmac('sha1', data.salt).update(password).digest 'hex'
    @knex("users")
      .where 'login', '=', login
      .update data
      .then (res)-> callback(null, res)
      .catch (err)->
        callback "Ошибка при задании пароля. Обратитесь в службу поддержки."
        console.error "Error in Users schema! Method 'setPassword':\n", err
  login: (login, password, callback)->
    @knex
      .select '*'
      .from 'users'
      .where { login: login }
      .then (rows)->
        if rows.length isnt 0
          user = rows[0]
          if user.password is crypto.createHmac('sha1', user.salt).update(password).digest 'hex'
            callback null, user
          else
            callback "Пароль неверный", null
        else
          callback "Пользователя с таким логином не существует", null
      .catch (err)->
        callback "Ошибка при попытке входа. Обратитесь в службу поддержки."
        console.error "Error in Users schema! Method 'login':\n", err
  loginByTemp: (temp, callback)->
    @knex
      .select '*'
      .from 'users'
      .where { temp: temp }
      .then (rows)->
        if rows.length isnt 0
          callback null, rows[0]
        else
          callback "Пользователя с такой временной ссылкой не существует", null
      .catch (err)->
        callback "Ошибка при попытке входа по временной ссылке. Обратитесь в службу поддержки."
        console.error "Error in Users schema! Method 'loginByTemp':\n", err

module.exports = UsersSchema