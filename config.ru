require 'sinatra/base'

require './controllers/application'
require './controllers/user'
require './controllers/hoonta'
require './controllers/idea'
require './controllers/topic'
require './controllers/vote'

require './models/idea'
require './models/hoonta'
require './models/user'
require './models/roster'
require './models/topic'
require './models/vote'

map ('/')       { run UserController }
map ('/hoonta') { run HoontaController }
map ('/topic')  { run TopicController }
map ('/idea')   { run IdeaController }
map ('/vote')   { run VoteController }
