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
  'profile/add.tablet.controller'
  'profile/add.poll.controller'
  'profile/edit.poll.controller'
  'profile/polls.controller'
  'profile/tablets.controller'
  'profile/set.password.controller'
  # Общие компоненты
  'common/directives/dropdownMenu'
  'common/directives/fullHeight'
  'common/directives/showOnLoaded'
  'common/directives/calendar'
  'common/directives/doughnut'
  'common/factories/errorHttpInterceptor'
  'common/services/alert'
  'common/services/modal'
  'common/services/users.service'
  'common/services/tablet.service'
  'common/services/polls.service'
  'common/controllers/loading'
  'common/filters/formatDate'
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
            .when '/add_tablet', { templateUrl: '/templates/add_tablet.html', controller: 'AddTabletController', controllerAs: 'AddTabletController' }
            .when '/add_poll', { templateUrl: '/templates/add_poll.html', controller: 'AddPollController', controllerAs: 'AddPollController' }
            .when '/polls', { templateUrl: '/templates/polls.html', controller: 'PollsController', controllerAs: 'PollsController' }
            .when '/tablets', { templateUrl: '/templates/tablets.html', controller: 'TabletsController', controllerAs: 'TabletsController' }
            .otherwise { redirectTo: '/home' }
          $httpProvider.interceptors.push 'errorHttpInterceptor'
