define [
  # Модули angularJs
  'angular-route'
  'angular-bootstrap'
  'angular-resource'
  "angular-validation-match"
  'ng-dialog'
  # Компоненты модуля
  'profile/home.controller'
  'profile/top.controller'
  'profile/add.user.controller'
  'profile/set.password.controller'
  # Общие компоненты
  'common/directives/dropdownMenu'
  'common/directives/fullHeight'
  'common/directives/showOnLoaded'
  'common/factories/errorHttpInterceptor'
  'common/services/alert'
  'common/services/users.service'
  'common/controllers/loading'
], ->
  class ProfileApp
    constructor: ()->
      for dependency in [ 'ngRoute', 'ngResource', 'ngDialog', 'ui.bootstrap', 'validation.match' ]
        angular.module('app').requires.push(dependency);
      
      angular.module('app')
        .config ($routeProvider, $httpProvider)->
          $routeProvider
            .when '/home', { templateUrl: '/templates/home.html', controller: 'HomeController', controllerAs: 'HomeController' }
            .when '/add_user', { templateUrl: '/templates/add_user.html', controller: 'AddUserController', controllerAs: 'AddUserController' }
            .otherwise { redirectTo: '/home' }
          $httpProvider.interceptors.push 'errorHttpInterceptor'
