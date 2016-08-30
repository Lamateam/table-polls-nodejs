define [ 'app' ], ->
  angular.module('app').controller 'SetPasswordController', [ 'UsersService', 'AlertService', SetPasswordController ]

class SetPasswordController
  constructor: (@UsersService, @AlertService)->
    @data = { password: '', password_again: '' }
    @reseted = false
  setPassword: (form)->
    if form.$valid
      @UsersService
        .password @data
        .then (res)=>
          if res.message is undefined
            @AlertService.success 
              text: 'Пароль успешно изменен!'
            @reseted = true