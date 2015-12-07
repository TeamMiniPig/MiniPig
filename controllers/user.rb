class UserController < ApplicationController

                                                  # detect collision
  def user_or_email_exists? user_name, email
    if User.find_by(user_name: user_name)
      true
    elsif User.find_by(email: email)
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
      p session[:current_user]
      redirect '/home'
    end
  end

                                                  # GET '/welcome'
  get '/welcome' do
    erb :welcome
  end

                                                  # GET '/home'
  get '/home' do
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
      session[:current_user] = user
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

    # Catch invalid username
    if user[:user_name].length < 4
      set_message "username must be four or more characters", "error"
      redirect '/register'

    # Catch invalid password
    elsif user[:password].length < 8
      set_message "password must be eight or more characters", "error"
      redirect 'register'

    # Catch name or email collision
    elsif user_or_email_exists? user[:user_name], user[:email]
      set_message "username or email is already is use", "error"
      redirect '/register'

    # If they make it this far, they can register!
    else
      new_user = User.create(user)
      session[:current_user] = new_user
      set_message "Account created.", "success"
      redirect '/'

    end

  end

                                                  # GET '/logout'
  get '/logout' do
    authorized?
    session[:current_user] = nil;
    set_message "Bye!", "success"
    redirect '/welcome'
  end
                                                  # GET '/not_authorized'
  get '/not_authorized' do
    erb :not_authorized
  end

end
