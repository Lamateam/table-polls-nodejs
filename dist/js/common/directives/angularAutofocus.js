(function() {
  define(['app'], function() {
    return angular.module('app').directive('angularAutofocus', function($timeout) {
      return {
        link: function(scope, element, attrs, ctrl) {
          scope.$watch(attrs.angularAutofocus, function(value) {
            if (value) {
              return $timeout(function() {
                return element[0].focus();
              });
            }
          });
        }
      };
    });
  });

}).call(this);
