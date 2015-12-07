require 'sinatra/base'

require './controllers/application'
require './controllers/user'
require './controllers/hoonta'
require './controllers/activity'
require './controllers/category'

require './models/activity'
require './models/category'
require './models/hoonta'
require './models/user'

map ('/') { run UserController }
map ('/hoonta') { run HoontaController }
map ('/activity') { run ActivityController }
