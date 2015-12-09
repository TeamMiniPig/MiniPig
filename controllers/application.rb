class ApplicationController < Sinatra::Base

  require 'bundler'
  Bundler.require

  ActiveRecord::Base.establish_connection(
    adapter: 'mysql2',
    database: 'hoonta_db'
  )

  enable :sessions

  set :views, File.expand_path('../../views', __FILE__)
  set :public_dir, File.expand_path('../../public', __FILE__)

  error Sinatra::NotFound do
    erb :not_found
  end
                                                  # ensure someone is logged in
  def authorized?

    if session[:current_user] != nil
      true
    else
      redirect '/not_authorized'
    end

  end

  def current_user
    User.find(session[:current_user])
  end

                                                  # handle session messages
                                                  # style = "success" or "error"
  def set_message message, style
    session[:message] = "
    <div class='row message-wrapper #{style}'>
      <div class=message>#{message}</div>
      <div class=close><i class='material-icons'>clear</i></div>
    </div>"
  end

                                                    # call in views
  def handle_message
    if session[:message]
      m = session[:message]
      session[:message] = nil
      m
    else
      ""
    end
  end

end
