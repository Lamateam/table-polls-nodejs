(function() {
  var LoginController;

  define(['app'], function() {
    return angular.module('app').controller('LoginController', ['$rootScope', 'UsersService', 'AlertService', '$window', LoginController]);
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
      this.data = {
        login: '',
        password: ''
      };
    }

    LoginController.prototype.login = function(form) {
      if (form.$valid) {
        return this.UsersService.login(this.data).then((function(_this) {
          return function(data) {
            if (data.message === void 0) {
              return _this.window.location.href = '/profile';
            }
          };
        })(this));
      }
    };

    return LoginController;

  })();

}).call(this);
