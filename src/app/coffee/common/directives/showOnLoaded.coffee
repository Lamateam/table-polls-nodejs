define [ 'app', 'jquery' ], ->
  angular.module('app').directive 'showOnLoaded', ($timeout)->
    {
      link: (scope, element, attrs, ctrl)->
        $timeout -> $(element).css 'display', 'block'
    }
     