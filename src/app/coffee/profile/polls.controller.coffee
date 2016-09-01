define [ 'app' ], ->
  angular.module('app').controller 'PollsController', [ 'PollsService', PollsController ]

class PollsController
  constructor: (@PollsService)->
    @polls = null
    @PollsService
      .list()
      .then (res)=>
        if res.message is undefined
          @polls = res.polls