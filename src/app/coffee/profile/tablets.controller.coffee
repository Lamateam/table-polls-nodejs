define [ 'app' ], ->
  angular.module('app').controller 'TabletsController', [ 'TabletService', 'PollsService', 'ModalService', TabletsController ]

class TabletsController
  constructor: (@TabletService, @PollsService, @ModalService)->
    @tablets = null
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets
  loadPolls: (tablet_link)->
    @PollsService
      .list {tablet_link: tablet_link}
      .then (res)=>
        @ModalService.open
          template: '/templates/polls_modal.html'
          data: 
            polls: res.polls
          # controller: [ 'PollsService', (PollsService)->
          #   @disablePoll = (poll)->
          #     poll.is_active = false
          #     PollsService.save poll
          #   @enablePoll = (poll)->
          #     poll.is_active = true
          #     PollsService.save poll
          #   return
          # ]