define [ 'app' ], ->
  angular.module('app').directive 'angularAutofocus', ($timeout)->
    {
      link: (scope, element, attrs, ctrl)->
        scope.$watch attrs.angularAutofocus, (value)->
          if value
            $timeout -> element[0].focus()
        return
    }
     