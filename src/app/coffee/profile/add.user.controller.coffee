define [ 'app' ], ->
  angular.module('app').controller 'AddUserController', [ 'UsersService', 'AlertService', AddUserController ]

class AddUserController
  constructor: (@UsersService, @AlertService)->
    @data = { mail: '' }
  invite: (form)->
    if form.$valid
      @UsersService
        .invite @data
        .then (res)=>
          if res.message is undefined
            @AlertService.success 
              text: 'Приглашение успешно отправлено на ящик ' + @data.mail + '. Если пользователь не получил письмо, просто отправьте ему эту ссылку: ' + res.link
            @data.mail = ''