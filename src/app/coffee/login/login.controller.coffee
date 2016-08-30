define [ 'app' ], ->
  angular.module('app').controller 'LoginController', [ '$rootScope', 'UsersService', 'AlertService', '$window', LoginController ]

class LoginController
  constructor: (@rootScope, @UsersService, @AlertService, @window)->
    @rootScope.$on "loading", (event, data)=> @loading = data

    @data = { login: '', password: '' }
  login: (form)->
    if form.$valid
      @UsersService
        .login @data
        .then (data)=>
          if data.message is undefined
            @window.location.href = '/profile'