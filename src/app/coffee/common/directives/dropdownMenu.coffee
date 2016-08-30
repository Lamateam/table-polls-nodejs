define [ 'app', 'jquery' ], ->
  angular.module('app').directive 'dropdownMenu', ->
    {
      link: (scope, element, attrs, ctrl)->
        element.on 'click', (ev)->
          ev.preventDefault()
          ev.stopPropagation()

          $li = $(element).parent()

          if $li.is '.active'
            $li.removeClass 'active active-sm'
            $('ul:first', $li).slideUp()
          else
            $li.addClass 'active'
            $('ul:first', $li).slideDown()
    }
     