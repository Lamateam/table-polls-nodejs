define [ 'app' ], ->
  angular.module('app').service 'ModalService', [ 'ngDialog', ModalService ]

class ModalService
  defaultOptions: 
    className: 'ngdialog-theme-default'
    controllerAs: '$ctrl'
    controller: ->
  constructor: (@ngDialog)->
  open: (options)->
    options = angular.merge options, @defaultOptions
    console.log options, @ngDialog.open(options)
  closeAll: ->
    @ngDialog.closeAll()