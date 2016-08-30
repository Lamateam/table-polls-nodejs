# Обёртка над библиотекой sweetalert
# http://t4t5.github.io/sweetalert/

define [ 'app', 'sweetalert' ], ->
  angular.module('app').service 'AlertService', AlertService

class AlertService
  defaultErrorOptions:
    title: 'Ой!'
    text: ''
    type: 'error'
    animation: false
    html: true
  defaultWarningOptions:
    title: 'Вы уверены?'
    text: ''
    type: 'warning'
    animation: false
    html: true
  defaultSuccessOptions:
    title: 'OK'
    text: ''
    type: 'success'
    animation: false
    html: true
  error: (options={})->
    for own key, value of @defaultErrorOptions
      options[key] = value if options[key] is undefined
    swal options
  warning: (options={}, handler=->)->
    for own key, value of @defaultWarningOptions
      options[key] = value if options[key] is undefined
    # в handler передаётся флаг isConfirm
    swal options, handler
  success: (options={})->
    for own key, value of @defaultSuccessOptions
      options[key] = value if options[key] is undefined
    swal options