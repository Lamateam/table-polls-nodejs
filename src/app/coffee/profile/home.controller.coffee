define [ 'app' ], ->
  angular.module('app').controller 'HomeController', [ 'UsersService', '$window', LoginController ]

class LoginController
  constructor: (@UsersService, @window)->
  logout: ->
    @UsersService
      .logout()
      .then (data)=>
        @window.location.href = '/login'