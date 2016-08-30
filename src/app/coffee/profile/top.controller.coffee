define [ 'app' ], ->
  angular.module('app').controller 'TopController', [ 'UsersService', '$window', TopController ]

class TopController
  constructor: (@UsersService, @window)->
  logout: ->
    @UsersService
      .logout()
      .then (data)=>
        @window.location.href = '/login'