class UserController < ApplicationController

                                                  # detect collision
  def user_exists? user_name
    if User.find_by(user_name: user_name.downcase)
      true
    else
      false
    end
  end

                                                  # GET /
  get '/' do
    if session[:current_user] == nil
      redirect '/welcome'
    else
      redirect '/home'
    end
  end

                                                  # GET '/welcome'
  get '/welcome' do
    erb :welcome
  end

                                                  # GET '/home'
  get '/home' do
    authorized?
    @rosters = Roster.where(user_id: session[:current_user])
    erb :user_home
  end

                                                  # GET '/login'
  get '/login' do
    erb :login
  end

                                                  # POST '/login'
  post '/login' do
    user = User.authenticate params[:user_name], params[:password]

    if user
      session[:current_user] = user.id
      set_message "Logged in.", "success"
      redirect '/'
    else
      set_message "Login failed.", "error"
      redirect '/login'
    end

  end

                                                  # GET '/register'
  get '/register' do
    erb :register
  end

                                                  # POST '/register'
  post '/register' do

    user = params[:user]

    # Catch password mis-match
    if user[:password] != params[:confirm_password]
      set_message "Passwords do not match.", "error"
      redirect '/register'

    # Catch invalid username
    elsif user[:user_name].length < 4
      set_message "Username must be four or more characters", "error"
      redirect '/register'

    # Catch invalid password
    elsif user[:password].length < 5
      set_message "Password must be five or more characters", "error"
      redirect 'register'

    # Catch name or email collision
    elsif user_exists? user[:user_name]
      set_message "Username or email is already is use", "error"
      redirect '/register'

    # If they make it this far, they can register!
    else
      new_user = User.create(user)
      session[:current_user] = new_user.id
      set_message "Account created.", "success"
      redirect '/home'

    end

  end

                                                  # GET '/logout'
  get '/logout' do
    authorized?
    session[:current_user] = nil;
    session[:hoonta] = nil;
    set_message "Bye!", "success"
    redirect '/welcome'
  end
                                                  # GET '/not_authorized'
  get '/not_authorized' do
    erb :not_authorized
  end

end
