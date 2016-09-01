define [ 'app' ], ->
  angular.module('app').service 'PollsService', [ '$rootScope', '$resource', '$q', PollsService ]

class PollsService
  constructor: (@rootScope, resource, @q)->

    @tabletResource = resource '/api/v1/polls/:action', null, 
      create:
        method: 'POST'
        params: { action: '' }
      list: 
        method: 'GET'
        params: { action: '' }

    @activeRequest = null

  sendAction: (action, data={})->
    @cancellActiveRequest()
    @rootScope.$broadcast "loading", true
    @activeRequest = @tabletResource[action] data
    @activeRequest.$promise.then (res)=>
      @rootScope.$broadcast "loading", false
      res

  create: (data)->
    @sendAction 'create', data
    
  list: ->
    @sendAction 'list'

  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')