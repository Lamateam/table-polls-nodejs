define [ 'chart', 'app' ], (Chart)->
  angular.module('app').directive 'doughnut', ($timeout)->
    {
      link: (scope, element, attrs, ctrl)->
        element = element[0]
        scope.$watch attrs.doughnut, (value)->
          if value
            console.log value
            $timeout -> 
              element.innerHtml = ''
              new Chart element, { type: 'doughnut', tooltipFillColor: "rgba(51, 51, 51, 0.55)", data: value }
        , true
        return
    }
     