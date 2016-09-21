define [ 'app', 'moment' ], ->
  angular.module('app').controller 'TabletsController', [ 'GroupsService', 'TabletService', 'PollsService', 'ModalService', TabletsController ]

class TabletsController
  constructor: (@GroupsService, @TabletService, @PollsService, @ModalService)->
    @tablets = null
    @groups  = [ ]
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets
    @GroupsService
      .list()
      .then (res)=>
        if res.message is undefined
          @groups = res.groups
  timeFromNow: (ts)->
    moment = require 'moment'
    moment().valueOf() - moment(ts).valueOf()
  changeGroup: (tablet)->
    
    @TabletService
      .group({ tablet_link: tablet.link, group_id: tablet.group.id })
  loadPolls: (tablet_link)->
    @PollsService
      .list {tablet_link: tablet_link}
      .then (res)=>
        @ModalService.open
          template: '/templates/polls_modal.html'
          data: 
            polls: res.polls