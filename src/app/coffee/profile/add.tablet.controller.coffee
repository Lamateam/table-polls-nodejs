define [ 'app' ], ->
  angular.module('app').controller 'AddTabletController', [ 'TabletService', '$location', AddTabletController ]

class AddTabletController
  constructor: (@TabletService, @location)->
    @data = { name: '' }
  create: (form)->
    if form.$valid
      @TabletService
        .create @data
        .then (res)=>
          if res.message is undefined
            @location.url '/tablets'