module = mean.module 'yournal.admin.issue'

module.config [
  '$stateProvider',
  ($stateProvider) ->
    $stateProvider.state('issue-new',
      url: '/admin/issue/new'
      templateUrl: module.mean.resource('admin/issue/admin-issue-new.html')
      controller: module.mean.namespace('IssueNewCtrl')
      data:
        access:
          allow: ['admin']
          state: 'login'
    )
    $stateProvider.state('issue-edit',
      url: '/admin/issue/edit/:year/:volume/:number'
      templateUrl: module.mean.resource('admin/issue/admin-issue-edit.html')
      controller: module.mean.namespace('IssueEditCtrl')
      data:
        access:
          allow: ['admin']
          state: 'login'
    )
]

module.controller module.mean.namespace('IssueNewCtrl'), [
  '$scope',
  'Issue',
  ($scope, Issue) ->
    $scope.year = new Date().getFullYear()
    $scope.maxYear = $scope.year
    $scope.error = []
    $scope.response = null

    $scope.createIssue = () ->
      Issue.save
        year: $scope.year
        volume: $scope.volume
        number: $scope.number
      ,
        (response) ->
          $scope.response = response
          $scope.error = []
          $scope.volume = null
          $scope.number = null
      ,
        (err) ->
          $scope.response = null
          if typeof err.data isnt 'object'
            $scope.error = [msg: err.data]
          else
            $scope.error = err.data
]

module.controller module.mean.namespace('IssueEditCtrl'), [
  '$scope',
  '$state',
  '$stateParams',
  'Issue',
  ($scope, $state, $stateParams, Issue) ->
    year = parseInt($stateParams.year)
    volume = parseInt($stateParams.volume)
    number = parseInt($stateParams.number)

    issue = Issue.get(
      year: year
      volume: volume
      number: number
    ,
      (response) ->
        return
    ,
      (err) ->
        $state.go '404'
    )

    $scope.year = year
    $scope.volume = volume
    $scope.number = number
    $scope.maxYear = new Date().getFullYear()
    $scope.error = []
    $scope.response = null

    $scope.updateIssue = () ->
      Issue.update
        year: year
        volume: volume
        number: number
      ,
        year: $scope.year
        volume: $scope.volume
        number: $scope.number
      ,
        (response) ->
          $scope.response = response
          year = $scope.year
          volume = $scope.volume
          number = $scope.number

          $state.go 'issue-edit',
            year: year
            volume: volume
            number: number

          $scope.error = []
      ,
        (err) ->
          $scope.response = null
          $scope.year = year
          $scope.volume = volume
          $scope.number = number

          if typeof err.data isnt 'object'
            $scope.error = [msg: err.data]
          else
            $scope.error = err.data
]

module.controller module.mean.namespace('DeleteCtrl'), [
  '$scope',
  '$rootScope',
  'Issue',
  'Message',
  ($scope, $rootScope, Issue, Message) ->
    $scope.delete = (year, volume, number) ->
      data =
        year: parseInt year
        volume: parseInt volume
        number: parseInt number

      Issue.delete(
        data
      ,
        (response) ->
          Message.add
            success: true
            msg: 'Issue successfully deleted.'
          $rootScope.$emit 'rebind'
      ,
        (err) ->
          Message.add
            success: false
            msg: err.msg
      )
]
