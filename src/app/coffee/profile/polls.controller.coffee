define [ 'app', 'moment' ], ->
  angular.module('app').controller 'PollsController', [ 'PollsService', 'TabletService', 'ModalService', PollsController ]

class PollsController
  constructor: (@PollsService, @TabletService, @ModalService)->
    @polls = null
    @PollsService
      .list()
      .then (res)=>
        if res.message is undefined
          @polls = res.polls
  isSelected: (poll)->
    moment = require 'moment'
    now = moment()
    moment(poll.start_date).isBefore(now) && !moment(poll.end_date).isBefore(now)
  disablePoll: (poll)->
    poll.is_active = false
    @PollsService.save poll
  enablePoll: (poll)->
    poll.is_active = true
    @PollsService.save poll
  edit: (poll)->
    require [ 'moment' ], (moment)=>
      poll = angular.copy poll 

      poll.start_date = moment(poll.start_date).format 'DD.MM.YYYY'
      poll.end_date   = moment(poll.end_date).format 'DD.MM.YYYY'
      poll.answers    = poll.answers.split ', '

      @TabletService
        .list { poll_id: poll.id }
        .then (res)=>
          @ModalService.open
            template: '/templates/edit_poll.html'
            data: 
              poll: poll
              active_tablets: res.tablets
            controller: 'EditPollController'