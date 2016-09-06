define [ 'app' ], ->
  angular.module('app').service 'AnswersService', [ '$rootScope', '$resource', '$q', AnswersService ]

class AnswersService
  constructor: (@rootScope, resource, @q)->

    @tabletResource = resource '/api/v1/tabletanswers/:action', null, 
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
    
  list: (data={})->
    @sendAction 'list', data

  cancellActiveRequest: ->
    @rootScope.$broadcast "loading", false
    @activeRequest.$cancelRequest() if (@activeRequest isnt null) and (typeof @activeRequest.$cancelRequest is 'function')