module = meanstack.module 'yournal.admin.article.new'

module.config [
  '$stateProvider',
  ($stateProvider) ->
    $stateProvider.state('article-new',
      url: '/admin/article/new'
      templateUrl: module.mean.resource('admin/article/admin-article-new.html')
    )
]
