module = mean.module 'yournal.admin.issue.new'

module.config [
  '$stateProvider',
  ($stateProvider) ->
    $stateProvider.state('issue-new',
      url: '/admin/issue/new'
      templateUrl: module.mean.resource('admin/issue/admin-issue-new.html')
      data:
        allow: ['admin']
    )
]
