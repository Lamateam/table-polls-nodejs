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
      save:
        method: 'PUT'
        params: { action: '' }
      active:
        method: 'POST'
        params: { action: 'active' }

    @activeRequest = null

  sendAction: (action, data={})->
    @rootScope.$broadcast "loading", true
    @activeRequest = @tabletResource[action] data
    @activeRequest.$promise.then (res)=>
      @rootScope.$broadcast "loading", false
      res

  create: (data)->
    @sendAction 'create', data
    
  list: (data={})->
    @sendAction 'list', data

  save: (data)->
    @sendAction 'save', data

  active: (data)->
    @sendAction 'active', data

  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')