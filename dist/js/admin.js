(function() {
  require.config({
    baseUrl: 'static/js/',
    paths: {
      "angular": "../bower/angular/angular.min",
      "angular-route": "../bower/angular-route/angular-route.min",
      "angular-resource": "../bower/angular-resource/angular-resource.min",
      "angular-bootstrap": "../bower/angular-bootstrap/ui-bootstrap.min",
      "ng-dialog": "../bower/ng-dialog/js/ngDialog.min",
      "jquery": "../bower/jquery/dist/jquery.min",
      "jquery-ui": "../bower/jquery-ui/jquery-ui.min",
      "sweetalert": "../bower/sweetalert/dist/sweetalert.min",
      "bootstrap": "../bower/bootstrap/dist/js/bootstrap.min"
    },
    shim: {
      "angular-route": {
        deps: ["angular"]
      },
      "angular-resource": {
        deps: ["angular"]
      },
      "ng-dialog": {
        deps: ["angular"]
      },
      "jquery-ui": {
        deps: ["jquery"]
      },
      "angular": {
        exports: "angular"
      },
      "bootstrap": {
        deps: ["jquery"]
      },
      "angular-bootstrap": {
        deps: ["bootstrap", "jquery"]
      }
    }
  });

  require([window.currentPage + "/app"], function(App) {
    new App();
    return angular.bootstrap(document, ['app']);
  });

}).call(this);
