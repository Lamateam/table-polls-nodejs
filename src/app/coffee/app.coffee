# Глобальный объект приложения единый для всех модулей
define 'app', [ 'angular' ], ->
  angular
    .module 'app', [ ]        
    .config ($interpolateProvider)->
      $interpolateProvider.startSymbol('[[').endSymbol(']]')