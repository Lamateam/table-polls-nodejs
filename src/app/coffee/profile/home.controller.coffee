define [ 'app' ], ->
  angular.module('app').controller 'HomeController', [ 'UsersService', 'AnswersService', '$window', LoginController ]

class LoginController
  constructor: (@UsersService, @AnswersService, @window)->
    @data = { }
    @data.stat = { }
  loadStat: ->
    require [ 'moment' ], (moment)=>
      @AnswersService
        .list { poll_id: @data.poll_id }
        .then (res)=>
          console.log res

          start_date = moment @data.start_date, 'DD.MM.YYYY'
          end_date   = moment @data.end_date, 'DD.MM.YYYY'

          genderCounter  = [ 0, 0, 0 ]
          # answersCounter = [ 0, 0, 0, 0 ]

          for answer in res.answers
            incorrect = false
            if (@data.start_date isnt undefined) and (@data.start_date.length isnt 0)
              incorrect = incorrect || moment(answer.created_at).isBefore(start_date)
            if (@data.end_date isnt undefined) and (@data.end_date.length isnt 0)
              incorrect = incorrect || !moment(answer.created_at).isBefore(end_date)
            if !incorrect
              genderCounter[if answer.person_male is null then 0 else (if answer.person_male then 1 else 0)]++
              # answersCounter[answer.answers]++

          @data.stat.gender  = {"labels": [ "Не указано", "Мужчины", "Женщины" ], "datasets": [ { "data": genderCounter, "backgroundColor": [ "#455C73", "#9B59B6" ], "hoverBackgroundColor": [ "#34495E", "#B370CF" ] } ] }
          # @data.stat.answers = {"labels": [ "Отлично", "Сойдёт", "Не очень", "Ужасно" ], "datasets": [ { "data": answersCounter, "backgroundColor": [ "#455C73", "#9B59B6", "#D0D0D0", "#BB00BB", "#C0C0C0" ], "hoverBackgroundColor": [ "#34495E", "#B370CF", "#D4D4D4", "#BB44BB", "#C4C4C4" ] } ] }

  logout: ->
    @UsersService
      .logout()
      .then (data)=>
        @window.location.href = '/login'