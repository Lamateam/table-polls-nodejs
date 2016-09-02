define [ 'app', 'moment' ], ->
  angular.module('app').controller 'PollsController', [ 'PollsService', PollsController ]

class PollsController
  constructor: (@PollsService)->
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