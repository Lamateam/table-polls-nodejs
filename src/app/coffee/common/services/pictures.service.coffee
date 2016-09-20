define [ 'app' ], ->
  angular.module('app').service 'PicturesService', [ '$rootScope', '$resource', '$q', PicturesService ]

class PicturesService
  constructor: (@rootScope, resource, @q)->

    @tabletResource = resource '/api/v1/pictures', null, 
      list: 
        method: 'GET'

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