define [ 'app', 'moment' ], ->
  angular.module('app').controller 'PollsController', [ 'PollsService', 'TabletService', 'ModalService', PollsController ]

class PollsController
  constructor: (@PollsService, @TabletService, @ModalService)->
    @polls = null
    @PollsService
      .list()
      .then (res)=>
        if res.message is undefined
          arr = [ ]
          for poll in res.polls
            if !poll.inChain 
              @getChain res.polls, poll
          @polls = res.polls
  getChain: (polls, poll)->
    parent = @findParent polls, poll.id
    while parent isnt null
      # Не показываем poll - он потомок в цепочке
      poll.inChain    = true
      # Пишем потомка в его родителя
      parent.child    = poll
      # Ищем родителя текущего родителя
      poll            = parent 
      parent          = @findParent polls, poll.id
    return poll 
  findParent: (polls, children_id)->
    for poll in polls 
      console.log poll.next, children_id, poll.next is children_id
      if poll.next is children_id
        return poll
    return null
  getAllChidren: (poll)->
    res = [ ]
    while poll.child 
      res.push poll.child 
      poll = poll.child
    res
  isSelected: (poll)->
    moment = require 'moment'
    now = moment()
    moment(poll.start_date).isBefore(now) && !moment(poll.end_date).isBefore(now)
  disablePoll: (poll)->
    poll.is_active = false
    @PollsService.active { id: poll.id, is_active: false }
  enablePoll: (poll)->
    poll.is_active = true
    @PollsService.active { id: poll.id, is_active: true }
  edit: (poll)->
    require [ 'moment' ], (moment)=>
      poll = angular.copy poll 

      poll.start_date = moment(poll.start_date).format 'DD.MM.YYYY'
      poll.end_date   = moment(poll.end_date).format 'DD.MM.YYYY'
      # poll.answers    = poll.answers.split ', '

      @TabletService
        .list { poll_id: poll.id }
        .then (res)=>
          @ModalService.open
            template: '/templates/edit_poll.html'
            data: 
              poll: poll
              active_groups: res.tablets
            controller: 'EditPollController'