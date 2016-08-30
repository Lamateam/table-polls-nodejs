define [ 'app', 'jquery' ], ->
  angular.module('app').directive 'fullHeight', ($timeout)->
    {
      link: (scope, element, attrs, ctrl)->
        $timeout -> $(element).css 'min-height', $(window).height()
    }
     