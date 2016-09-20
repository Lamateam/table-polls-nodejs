define [ 'app', 'moment' ], (moment)->
  angular.module('app').controller 'PicturesController', [ '$scope', 'ModalService', 'PicturesService', PicturesController ]

class PicturesController
  constructor: (@scope, @ModalService, PicturesService)->
    @pictures = [ ]
    PicturesService
      .list()
      .then (res)=>
        if res.message is undefined
          @pictures = res.pictures
  select: (picture)->
    @scope.ngDialogData.custom_answer.url = picture.url
    @ModalService.closeAll()
              