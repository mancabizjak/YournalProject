module = meanstack.module 'yournal.search', [
  'yournal.services'
]

module.config [
  '$stateProvider',
  ($stateProvider) ->
    $stateProvider.state('search',
      url: '/search'
      templateUrl: module.mean.resource('search/search.html')
      controller: module.mean.module('SearchCtrl')
    )
]

module.controller module.mean.module('SearchCtrl'), [
  '$scope',
  'Article',
  ($scope, Article) ->
    $scope.articles = Article.getArticles()
    $scope.query = {}
    $scope.query.result = '!'
    $scope.module = (query) ->
      if !(query?) || query.length == 0
        query = '!'
      $scope.query.result = query
]
