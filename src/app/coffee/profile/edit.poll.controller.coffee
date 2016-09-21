define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'EditPollController', [ 'FileUploader', '$scope', 'GroupsService', 'PollsService', 'ModalService', '$route', EditPollController ]

class EditPollController
  constructor: (@FileUploader, @scope, @GroupsService, @PollsService, @ModalService, @route)->
    ngDialogData = @scope.ngDialogData
    poll         = ngDialogData.poll
    data         = { questions: [  ], success_text: poll.success_text, tablets: [ ], start_date: poll.start_date, end_date: poll.end_date }

    console.log poll

    while poll
      question = { text: poll.question, custom_answers: [ ], answers: [ ], id: poll.id }
      poll.answers = poll.answers.split ', '
      for i in [0..3]
        question.answers.push if poll.answers.indexOf(i+'') is -1 then undefined else i
      for answer in poll.answers 
        question.custom_answers.push JSON.parse(answer) if answer.length > 2
      data.questions.push question
      poll = poll.child

    console.log data

    @data        = data
    @data.groups = [ ]
    @groups      = [ ]
    @loadGroups()
  loadGroups: ->
    @GroupsService
      .list()
      .then (res)=>
        if res.message is undefined
          for group in res.groups
            has = false
            for a_group in @scope.ngDialogData.active_groups
              if a_group.group_id is group.id
                @data.groups.push parseInt(a_group.id, 10)
                has = true
            @data.groups.push undefined if !has
          @groups = res.groups
  isTabletChecked: (link, hash)->
    for element in hash
      if element.link is link
        return true
    return false
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
  edit: (form)->
    require [ 'moment' ], (moment)=>
      data = angular.copy @data

      for question in data.questions
        question.answers = question.answers.filter (el)-> el isnt undefined
        for custom_answer in question.custom_answers
          question.answers.push(JSON.stringify(custom_answer)) if custom_answer.text

      data.groups    = data.groups.filter (el)-> el isnt undefined
      data.start_date = moment(data.start_date, 'DD.MM.YYYY').toDate()
      data.end_date   = moment(data.end_date, 'DD.MM.YYYY').toDate()

      if data.groups.length isnt 0
        @PollsService
          .save data
          .then (res)=>
            if res.message is undefined
              @route.reload()
              @ModalService.closeAll()
              