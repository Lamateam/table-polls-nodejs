define [ 'app' ], ->
  angular.module('app').factory 'errorHttpInterceptor', [ 'AlertService', errorHttpInterceptor ]

errorHttpInterceptor = (AlertService)->
  response: (response)->
    if response.status > 399
      is_show = (response.status < 500) and !!response.data and (response.data.message isnt undefined)
      message = if is_show then response.data.message else 'На сервере произошла ошибка. Наши специалисты уже работают над этой проблемой. Приносим свои извинения.'

      AlertService.error { text: message }

      console.log('Unhandled error: ', response) if !is_show

    response

  responseError: (response)->
    return response if response.status == -1
    
    is_show = (response.status < 500) and !!response.data and (response.data.message isnt undefined)
    message = if is_show then response.data.message else 'На сервере произошла ошибка. Наши специалисты уже работают над этой проблемой. Приносим свои извинения.'

    AlertService.error { text: message }

    console.log('Unhandled error: ', response) if !is_show

    response
