(function() {
  define('app', ['angular'], function() {
    return angular.module('app', []).config(function($interpolateProvider) {
      return $interpolateProvider.startSymbol('[[').endSymbol(']]');
    });
  });

}).call(this);
