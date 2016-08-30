(function() {
  define(['app', 'jquery'], function() {
    return angular.module('app').directive('fullHeight', function($timeout) {
      return {
        link: function(scope, element, attrs, ctrl) {
          return $timeout(function() {
            return $(element).css('min-height', $(window).height());
          });
        }
      };
    });
  });

}).call(this);
