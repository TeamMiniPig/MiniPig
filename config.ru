require 'sinatra/base'

require './controllers/application'
require './controllers/user'
require './controllers/hoonta'
require './controllers/activity'
require './controllers/category'
require './controllers/roster'

require './models/activity'
require './models/category'
require './models/hoonta'
require './models/user'
require './models/roster'

map ('/') { run UserController }
map ('/hoonta') { run HoontaController }
map ('/roster') { run RosterController }
map ('/activity') { run ActivityController }
