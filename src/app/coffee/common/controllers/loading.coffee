define [ 'app' ], ->
  angular.module('app').controller 'LoadingController', [ '$rootScope', LoadingController ]

class LoadingController
  constructor: (rootScope)->
    rootScope.$on "loading", (event, data)=> 
      @loading = data