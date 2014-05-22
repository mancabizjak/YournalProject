exports.route = ($route, auth, SectionCtrl) ->
  $route.get '/issues/:year/:volume/:number/sections', (req, res) ->
    SectionCtrl.getSections req, res

  $route.get '/issues/:year/:volume/:number/sections/:section', (req, res) ->
    SectionCtrl.getSection req, res

  $route.post '/issues/:year/:volume/:number/sections', auth(['admin']), (req, res) ->
    SectionCtrl.createSection req, res

  $route.delete '/issues/:year/:volume/:number/sections/:section', auth(['admin']), (req, res) ->
    SectionCtrl.deleteSection req, res

  $route.put '/issues/:year/:volume/:number/sections/:section', auth(['admin']), (req, res) ->
    SectionCtrl.updateSection req, res

  return '/api'
