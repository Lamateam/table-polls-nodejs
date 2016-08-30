(function() {
  define(['app', 'jquery'], function() {
    return angular.module('app').directive('dropdownMenu', function() {
      return {
        link: function(scope, element, attrs, ctrl) {
          return element.on('click', function(ev) {
            var $li;
            ev.preventDefault();
            ev.stopPropagation();
            $li = $(element).parent();
            if ($li.is('.active')) {
              $li.removeClass('active active-sm');
              return $('ul:first', $li).slideUp();
            } else {
              $li.addClass('active');
              return $('ul:first', $li).slideDown();
            }
          });
        }
      };
    });
  });

}).call(this);
