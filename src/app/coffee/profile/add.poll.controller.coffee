define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'AddPollController', [ 'TabletService', 'PollsService', '$location', AddPollController ]

class AddPollController
  constructor: (@TabletService, @PollsService, @location)->
    @data    = { questions: [ '' ], answers: [ [ ] ], success_text: '', tablets: [ ] }
    @tablets = [ ]
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets
  addNewQuestion: ->
    @data.questions.push ''
    @data.answers.push [ ]
    console.log @data
  create: (form)->
    require [ 'moment' ], (moment)=>
      data = angular.copy @data

      for answers in data.answers
        answers    = answers.filter (el)-> el isnt undefined

      data.tablets    = data.tablets.filter (el)-> el isnt undefined
      data.start_date = moment(data.start_date, 'DD.MM.YYYY').toDate()
      data.end_date   = moment(data.end_date, 'DD.MM.YYYY').toDate()
      
      if data.tablets.length isnt 0
        console.log data
        @PollsService
          .create data
          .then (res)=>
            if res.message is undefined
              @location.url '/polls'