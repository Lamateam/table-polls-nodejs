define [
  # Модули angularJs
  'angular-route'
  'angular-bootstrap'
  'angular-resource'
  'ng-dialog'
  # Компоненты модуля
  'profile/home.controller'
  'profile/top.controller'
  'profile/add.user.controller'
  # Общие компоненты
  'common/directives/dropdownMenu'
  'common/directives/fullHeight'
  'common/factories/errorHttpInterceptor'
  'common/services/alert'
  'common/services/users.service'
], ->
  class ProfileApp
    constructor: ()->
      for dependency in [ 'ngRoute', 'ngResource', 'ngDialog', 'ui.bootstrap' ]
        angular.module('app').requires.push(dependency);
      
      angular.module('app')
        .config ($routeProvider, $httpProvider)->
          $routeProvider
            .when '/home', { templateUrl: '/templates/home.html', controller: 'HomeController', controllerAs: 'HomeController' }
            .when '/add_user', { templateUrl: '/templates/add_user.html', controller: 'AddUserController', controllerAs: 'AddUserController' }
            .otherwise { redirectTo: '/home' }
          $httpProvider.interceptors.push 'errorHttpInterceptor'
