(function() {
  var TopController;

  define(['app'], function() {
    return angular.module('app').controller('TopController', ['UsersService', '$window', TopController]);
  });

  TopController = (function() {
    function TopController(UsersService, window) {
      this.UsersService = UsersService;
      this.window = window;
    }

    TopController.prototype.logout = function() {
      return this.UsersService.logout().then((function(_this) {
        return function(data) {
          return _this.window.location.href = '/login';
        };
      })(this));
    };

    return TopController;

  })();

}).call(this);
