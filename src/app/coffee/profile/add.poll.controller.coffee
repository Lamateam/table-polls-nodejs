define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'AddPollController', [ 'ModalService', 'TabletService', 'PollsService', 'GroupsService', 'FileUploader', '$location', AddPollController ]

class AddPollController
  constructor: (@ModalService, @TabletService, @PollsService, @GroupsService, @FileUploader, @location)->
    @data    = 
      questions: [ { text: '', custom_answers: [ ], answers: [ ] } ]
      success_text: ''
      groups: [ ] 

    @groups  = [ ]
    @GroupsService
      .list()
      .then (res)=>
        if res.message is undefined
          @groups = res.groups
  addNewQuestion: ->
    @data.questions.push { text: '', custom_answers: [], answers: [ ] }
    console.log @data
  addNewAnswer: (question)->
    question.custom_answers.push({ text: '', url: '' })
  getUploader: (custom_answer)->
    uploader = new @FileUploader
      url: '/api/v1/pictures'
    uploader.onAfterAddingFile = (item)->
      item.upload()
    uploader.onSuccessItem = (item, res)->
      console.log res 
      custom_answer.url = res.picture
    uploader
  openGallery: (custom_answer)->
    @ModalService.open
      template: '/templates/gallery_modal.html'
      data: 
        custom_answer: custom_answer
      controller: 'PicturesController'
  create: (form)->
    require [ 'moment' ], (moment)=>
      data = angular.copy @data

      for question in data.questions
        question.answers = question.answers.filter (el)-> el isnt undefined
        for custom_answer in question.custom_answers
          question.answers.push(JSON.stringify(custom_answer)) if custom_answer.text

      data.groups     = data.groups.filter (el)-> el isnt undefined
      data.start_date = moment(data.start_date, 'DD.MM.YYYY').toDate()
      data.end_date   = moment(data.end_date, 'DD.MM.YYYY').toDate()
      
      if data.groups.length isnt 0
        console.log data
        @PollsService
          .create data
          .then (res)=>
            if res.message is undefined
              @location.url '/polls'