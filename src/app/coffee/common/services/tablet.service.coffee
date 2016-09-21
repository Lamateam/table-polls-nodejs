define [ 'app' ], ->
  angular.module('app').service 'TabletService', [ '$rootScope', '$resource', '$q', TabletService ]

class TabletService
  constructor: (@rootScope, resource, @q)->

    @tabletResource = resource '/api/v1/tablet/:action', null, 
      create:
        method: 'POST'
        params: { action: '' }
      list: 
        method: 'GET'
        params: { action: '' }
      group:
        method: 'POST'
        params: { action: 'group' }

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
    
  list: (data={})->
    @sendAction 'list', data

  group: (data)->
    @sendAction 'group', data

  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')