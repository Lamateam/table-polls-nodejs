define [ 'app' ], ->
  angular.module('app').service 'UsersService', [ '$rootScope', '$resource', '$q', UsersService ]

class UsersService
  constructor: (@rootScope, resource, @q)->

    @usersResource = resource '/api/v1/users/:action', null, 
      login:
        method: "POST"
        params: { action: 'login' }
      logout:
        method: "POST"
        params: { action: 'logout' }
      invite:
        method: "POST"
        params: { action: 'invite' }
      password:
        method: "POST"
        params: { action: 'password' }

    @activeRequest = null

  sendAction: (action, data)->
    @cancellActiveRequest()
    @rootScope.$broadcast "loading", true
    @activeRequest = @usersResource[action] data
    @activeRequest.$promise.then (res)=>
      @rootScope.$broadcast "loading", false
      res

  login: (data)->
    @sendAction 'login', data

  logout: (data)->
    @sendAction 'logout', data

  invite: (data)->
    @sendAction 'invite', data

  password: (data)->
    @sendAction 'password', data
    
  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')