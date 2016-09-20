define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'AddGroupController', [ 'TabletService', 'GroupsService', '$location', AddGroupController ]

class AddGroupController
  constructor: (@TabletService, @GroupsService, @location)->
    @data    = { name: '', tablets: [ ] }
    @tablets = [ ]
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets
  create: (form)->
    data = angular.copy @data

    data.tablets    = data.tablets.filter (el)-> el isnt undefined
    
    if data.tablets.length isnt 0
      console.log data
      @GroupsService
        .create data
        .then (res)=>
          if res.message is undefined
            @location.url '/tablets'