define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'EditPollController', [ '$scope', 'TabletService', 'PollsService', 'ModalService', EditPollController ]

class EditPollController
  constructor: (@scope, @TabletService, @PollsService, @ModalService)->
    ngDialogData = @scope.ngDialogData
    poll         = ngDialogData.poll

    answers = [ ]
    i       = 0
    for i in [0..3]
      answers.push if poll.answers.indexOf(i+'') is -1 then undefined else i
    poll.answers = answers

    @data    = poll
    @data.tablets = [ ]
    @tablets = [ ]
  loadTablets: ->
    console.log 'here'
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          for tablet in res.tablets
            has = false
            for a_tablet in @scope.ngDialogData.active_tablets
              if a_tablet.link is tablet.link
                @data.tablets.push parseInt(a_tablet.link, 10)
                has = true
            @data.tablets.push undefined if !has
          console.log @data.tablets
          @tablets = res.tablets
  isTabletChecked: (link, hash)->
    for element in hash
      if element.link is link
        return true
    return false
  edit: (form)->
    require [ 'moment' ], (moment)=>
      data = angular.copy @data
      data.answers    = data.answers.filter (el)-> el isnt undefined
      data.tablets    = data.tablets.filter (el)-> el isnt undefined
      data.start_date = moment(data.start_date, 'DD.MM.YYYY').toDate()
      data.end_date   = moment(data.end_date, 'DD.MM.YYYY').toDate()
      console.log data, form
      if (data.question.length > 0) && (data.answers.length > 1) && (data.tablets.length isnt 0)
        console.log data
        @PollsService
          .save data
          .then (res)=>
            if res.message is undefined
              @ModalService.closeAll()