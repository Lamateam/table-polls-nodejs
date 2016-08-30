(function() {
  define(['angular-route', 'angular-resource', 'ng-dialog', 'login/login.controller', 'common/directives/angularAutofocus', 'common/factories/errorHttpInterceptor', 'common/services/alert', 'common/services/users.service'], function() {
    var LoginApp;
    return LoginApp = (function() {
      function LoginApp() {
        var dependency, i, len, ref;
        ref = ['ngRoute', 'ngResource', 'ngDialog'];
        for (i = 0, len = ref.length; i < len; i++) {
          dependency = ref[i];
          angular.module('app').requires.push(dependency);
        }
        angular.module('app').config(function($routeProvider, $httpProvider) {
          $routeProvider.when('/login', {
            templateUrl: '/templates/login.html',
            controller: 'LoginController',
            controllerAs: 'LoginController'
          }).otherwise({
            redirectTo: '/login'
          });
          return $httpProvider.interceptors.push('errorHttpInterceptor');
        });
      }

      return LoginApp;

    })();
  });

}).call(this);
