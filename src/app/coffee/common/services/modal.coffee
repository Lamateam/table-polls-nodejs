define [ 'app' ], ->
  angular.module('app').service 'ModalService', [ 'ngDialog', ModalService ]

class ModalService
  defaultOptions: 
    className: 'ngdialog-theme-default'
    controllerAs: '$ctrl'
  constructor: (@ngDialog)->
  open: (options)->
    options = angular.merge options, @defaultOptions
    @ngDialog.open options
  closeAll: ->
    @ngDialog.closeAll()