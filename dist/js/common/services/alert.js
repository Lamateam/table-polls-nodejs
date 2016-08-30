(function() {
  var AlertService,
    hasProp = {}.hasOwnProperty;

  define(['app', 'sweetalert'], function() {
    return angular.module('app').service('AlertService', AlertService);
  });

  AlertService = (function() {
    function AlertService() {}

    AlertService.prototype.defaultErrorOptions = {
      title: 'Ой!',
      text: '',
      type: 'error',
      animation: false,
      html: true
    };

    AlertService.prototype.defaultWarningOptions = {
      title: 'Вы уверены?',
      text: '',
      type: 'warning',
      animation: false,
      html: true
    };

    AlertService.prototype.defaultSuccessOptions = {
      title: 'OK',
      text: '',
      type: 'success',
      animation: false,
      html: true
    };

    AlertService.prototype.error = function(options) {
      var key, ref, value;
      if (options == null) {
        options = {};
      }
      ref = this.defaultErrorOptions;
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        value = ref[key];
        if (options[key] === void 0) {
          options[key] = value;
        }
      }
      return swal(options);
    };

    AlertService.prototype.warning = function(options, handler) {
      var key, ref, value;
      if (options == null) {
        options = {};
      }
      if (handler == null) {
        handler = function() {};
      }
      ref = this.defaultWarningOptions;
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        value = ref[key];
        if (options[key] === void 0) {
          options[key] = value;
        }
      }
      return swal(options, handler);
    };

    AlertService.prototype.success = function(options) {
      var key, ref, value;
      if (options == null) {
        options = {};
      }
      ref = this.defaultSuccessOptions;
      for (key in ref) {
        if (!hasProp.call(ref, key)) continue;
        value = ref[key];
        if (options[key] === void 0) {
          options[key] = value;
        }
      }
      return swal(options);
    };

    return AlertService;

  })();

}).call(this);
