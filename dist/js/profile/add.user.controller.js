(function() {
  var AddUserController;

  define(['app'], function() {
    return angular.module('app').controller('AddUserController', ['UsersService', 'AlertService', AddUserController]);
  });

  AddUserController = (function() {
    function AddUserController(UsersService, AlertService) {
      this.UsersService = UsersService;
      this.AlertService = AlertService;
      this.data = {
        mail: ''
      };
    }

    AddUserController.prototype.invite = function(form) {
      if (form.$valid) {
        return this.UsersService.invite(this.data).then((function(_this) {
          return function(res) {
            if (res.message === void 0) {
              _this.AlertService.success({
                text: 'Приглашение успешно отправлено на ящик ' + _this.data.mail
              });
              return _this.data.mail = '';
            }
          };
        })(this));
      }
    };

    return AddUserController;

  })();

}).call(this);
