(function() {
  define(['angular-route', 'angular-bootstrap', 'angular-resource', 'ng-dialog', 'profile/home.controller', 'profile/top.controller', 'profile/add.user.controller', 'common/directives/dropdownMenu', 'common/directives/fullHeight', 'common/factories/errorHttpInterceptor', 'common/services/alert', 'common/services/users.service'], function() {
    var ProfileApp;
    return ProfileApp = (function() {
      function ProfileApp() {
        var dependency, i, len, ref;
        ref = ['ngRoute', 'ngResource', 'ngDialog', 'ui.bootstrap'];
        for (i = 0, len = ref.length; i < len; i++) {
          dependency = ref[i];
          angular.module('app').requires.push(dependency);
        }
        angular.module('app').config(function($routeProvider, $httpProvider) {
          $routeProvider.when('/home', {
            templateUrl: '/templates/home.html',
            controller: 'HomeController',
            controllerAs: 'HomeController'
          }).when('/add_user', {
            templateUrl: '/templates/add_user.html',
            controller: 'AddUserController',
            controllerAs: 'AddUserController'
          }).otherwise({
            redirectTo: '/home'
          });
          return $httpProvider.interceptors.push('errorHttpInterceptor');
        });
      }

      return ProfileApp;

    })();
  });

}).call(this);
