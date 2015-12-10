class HoontaController < ApplicationController

  def set_hoonta hoonta_id
    session[:hoonta] = hoonta_id
  end
  def clear_hoonta
    session[:hoonta] = nil
  end

  get '/' do
    authorized?
    clear_hoonta
    redirect '/hoonta/all'
  end

  get '/all' do
    authorized?
    clear_hoonta
    erb :hoonta_landing
  end

  post '/all' do
    authorized?
    set_hoonta params[:id]
    redirect '/hoonta/home'
  end

  get '/home' do
    authorized?
    if session[:hoonta]
      erb :hoonta_home
    end
  end

  get '/join' do
    authorized?
    erb :join_hoonta
  end
  post '/join' do
    authorized?
    user = current_user
    hoonta_name = params[:hoonta_name]

    if hoonta_name
#      hoonta_name = hoonta_name.downcase
      hoonta = Hoonta.find_by(hoonta_name: hoonta_name)

      if hoonta
        if Roster.find_by(user_id: user.id, hoonta_id: hoonta.id)
          set_message "You're already in that Hoonta.", "error"
          redirect '/home'

        elsif hoonta.hoonta_password.nil? or
              params[:password] == hoonta.hoonta_password

          Roster.create(user_id: user.id, hoonta_id: hoonta.id)
          set_message "Hoonta joined.", "success"
          set_hoonta hoonta.id
          redirect '/hoonta/home'

        else
          set_message "Incorrect password.", "error"
          erb :join_hoonta
        end

      else
        set_message "No matches.", "error"
        erb :join_hoonta
      end

    end
  end

  get '/create' do
    authorized?
    erb :create_hoonta
  end
  post '/create' do
    authorized?

    # Catch invalid name
    if params[:hoonta_name].length < 3
      set_message "Hoonta name must be three or more characters long.", 'error'
      redirect '/hoonta/create'

    # Catch invalid password
    elsif params[:enable_password] and params[:hoonta_password].length < 4
      set_message 'Password must be four or more characters long.', 'error'
      redirect '/hoonta/create'

    # Otherwise they're good to go
    else
      if not params[:enable_password]
        params[:hoonta_password] = nil;
      end
      hoonta = Hoonta.create(hoonta_name: params[:hoonta_name],
                              hoonta_password: params[:hoonta_password])
      set_message 'Hoonta created.', 'success'
      user = current_user
      Roster.create(user_id: user.id, hoonta_id: hoonta.id)
      set_hoonta hoonta.id
      redirect '/hoonta/home'
    end
  end

  get '/leave' do
    Roster.find_by(user_id: current_user.id, hoonta_id: get_hoonta.id).destroy
    redirect '/hoonta/all'
  end


end
