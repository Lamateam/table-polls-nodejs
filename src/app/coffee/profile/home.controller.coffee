define [ 'app' ], ->
  angular.module('app').controller 'HomeController', [ '$rootScope', 'UsersService', 'AlertService', '$window', LoginController ]

class LoginController
  constructor: (@rootScope, @UsersService, @AlertService, @window)->
    @rootScope.$on "loading", (event, data)=> @loading = data
  logout: ->
    @UsersService
      .logout()
      .then (data)=>
        @window.location.href = '/login'