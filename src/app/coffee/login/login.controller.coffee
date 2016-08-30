define [ 'app' ], ->
  angular.module('app').controller 'LoginController', [ 'UsersService', '$window', LoginController ]

class LoginController
  constructor: (@UsersService, @window)->
    @data = { login: '', password: '' }
  login: (form)->
    if form.$valid
      @UsersService
        .login @data
        .then (data)=>
          if data.message is undefined
            @window.location.href = '/profile'