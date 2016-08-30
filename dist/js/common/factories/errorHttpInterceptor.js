(function() {
  var errorHttpInterceptor;

  define(['app'], function() {
    return angular.module('app').factory('errorHttpInterceptor', ['AlertService', errorHttpInterceptor]);
  });

  errorHttpInterceptor = function(AlertService) {
    return {
      response: function(response) {
        var is_show, message;
        if (response.status > 399) {
          is_show = (response.status < 500) && !!response.data && (response.data.message !== void 0);
          message = is_show ? response.data.message : 'На сервере произошла ошибка. Наши специалисты уже работают над этой проблемой. Приносим свои извинения.';
          AlertService.error({
            text: message
          });
          if (!is_show) {
            console.log('Unhandled error: ', response);
          }
        }
        return response;
      },
      responseError: function(response) {
        var is_show, message;
        if (response.status === -1) {
          return response;
        }
        is_show = (response.status < 500) && !!response.data && (response.data.message !== void 0);
        message = is_show ? response.data.message : 'На сервере произошла ошибка. Наши специалисты уже работают над этой проблемой. Приносим свои извинения.';
        AlertService.error({
          text: message
        });
        if (!is_show) {
          console.log('Unhandled error: ', response);
        }
        return response;
      }
    };
  };

}).call(this);
