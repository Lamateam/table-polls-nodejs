define [ 'app' ], ->
  angular.module('app').service 'GroupsService', [ '$rootScope', '$resource', '$q', GroupsService ]

class GroupsService
  constructor: (@rootScope, resource, @q)->

    @tabletResource = resource '/api/v1/groups/:action', null, 
      list: 
        method: 'GET'
        params: { action: '' }
      create:
        method: 'POST'
        params: { action: '' }

    @activeRequest = null

  sendAction: (action, data={})->
    @cancellActiveRequest()
    @rootScope.$broadcast "loading", true
    @activeRequest = @tabletResource[action] data
    @activeRequest.$promise.then (res)=>
      @rootScope.$broadcast "loading", false
      res
    
  list: (data={})->
    @sendAction 'list', data

  create: (data)->
    @sendAction 'create', data

  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')