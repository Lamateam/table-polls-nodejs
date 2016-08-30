(function() {
  define(['app', 'bootstrap'], function() {
    return angular.module('app').directive('dropdown', function($timeout) {
      return {
        link: function(scope, element, attrs, ctrl) {
          return $timeout(function() {
            return $(element).dropdown();
          });
        }
      };
    });
  });

}).call(this);
