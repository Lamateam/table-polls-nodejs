(function() {
  var LoginController;

  define(['app'], function() {
    return angular.module('app').controller('HomeController', ['$rootScope', 'UsersService', 'AlertService', '$window', LoginController]);
  });

  LoginController = (function() {
    function LoginController(rootScope, UsersService, AlertService, window) {
      this.rootScope = rootScope;
      this.UsersService = UsersService;
      this.AlertService = AlertService;
      this.window = window;
      this.rootScope.$on("loading", (function(_this) {
        return function(event, data) {
          return _this.loading = data;
        };
      })(this));
    }

    LoginController.prototype.logout = function() {
      return this.UsersService.logout().then((function(_this) {
        return function(data) {
          return _this.window.location.href = '/login';
        };
      })(this));
    };

    return LoginController;

  })();

}).call(this);
