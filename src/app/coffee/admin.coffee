require.config
  baseUrl: 'static/js/'
  paths:
    "angular": "../bower/angular/angular.min"
    "angular-route": "../bower/angular-route/angular-route.min"
    "angular-resource": "../bower/angular-resource/angular-resource.min"
    "angular-bootstrap": "../bower/angular-bootstrap/ui-bootstrap.min"
    "angular-validation-match": "../bower/angular-validation-match/dist/angular-validation-match.min"
    "ng-dialog": "../bower/ng-dialog/js/ngDialog.min"
    "jquery": "../bower/jquery/dist/jquery.min"
    "jquery-ui": "../bower/jquery-ui/jquery-ui.min"
    "sweetalert": "../bower/sweetalert/dist/sweetalert.min"
    "bootstrap": "../bower/bootstrap/dist/js/bootstrap.min"
    "chart": "../bower/chart.js/dist/Chart.min"
    "moment": "../bower/moment/min/moment-with-locales.min"
  shim:
    "angular-route":
      deps: [ "angular" ]
    "angular-resource":
      deps: [ "angular" ]
    "ng-dialog":
      deps: [ "angular" ]
    "jquery-ui":
      deps: [ "jquery" ]
    "angular":
      exports: "angular"
    "bootstrap":
      deps: [ "jquery" ]
    "angular-bootstrap":
      deps: [ "bootstrap", "jquery" ]
    "angular-validation-match":
      deps: [ "angular" ]
    
require [ window.currentPage + "/app" ], (App)->
  new App()
  angular.bootstrap document, [ 'app' ]
