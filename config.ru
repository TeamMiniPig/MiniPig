require 'sinatra/base'

require './controllers/application'
require './controllers/user'
require './controllers/caucus'
require './controllers/activity'
require './controllers/category'

require './models/activity'
require './models/category'
require './models/caucus'
require './models/user'

map ('/') { run UserController }
map ('/caucus') { run CaucusController }
map ('/activity') { run ActivityController }
