define [ 'app' ], ->
  angular.module('app').controller 'TabletsController', [ 'TabletService', TabletsController ]

class TabletsController
  constructor: (@TabletService, @location)->
    @tablets = null
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets