define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'AddPollController', [ 'TabletService', 'PollsService', '$location', AddPollController ]

class AddPollController
  constructor: (@TabletService, @PollsService, @location)->
    @data    = { questions: [ { text: '', custom_answers: [], answers: [ ] } ], success_text: '', tablets: [ ] }
    @tablets = [ ]
    @TabletService
      .list()
      .then (res)=>
        if res.message is undefined
          @tablets = res.tablets
  addNewQuestion: ->
    @data.questions.push { text: '', custom_answers: [], answers: [ ] }
    console.log @data
  addNewAnswer: (question)->
    question.custom_answers.push({ text: '', url: '/static/images/happy.png' })
  create: (form)->
    require [ 'moment' ], (moment)=>
      data = angular.copy @data

      for question in data.questions
        question.answers = question.answers.filter (el)-> el isnt undefined
        for custom_answer in question.custom_answers
          question.answers.push(JSON.stringify(custom_answer)) if custom_answer.text

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