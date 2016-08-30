define [ 'app', 'bootstrap' ], ->
  angular.module('app').directive 'dropdown', ($timeout)->
    {
      link: (scope, element, attrs, ctrl)->
        $timeout -> $(element).dropdown()
    }
     