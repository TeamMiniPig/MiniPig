class HoontaController < ApplicationController

  def set_hoonta hoonta_id
    session[:hoonta] = hoonta_id
  end
  def get_hoonta
    Hoonta.find(session[:hoonta])
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
  post '/all:id' do
    authorized?
    set_hoonta params[:id]
    redirect '/hoonta/home'
  end

  get '/home' do
    authorized?
    if get_hoonta
      erb :hoonta_home
    else
      redirect '/hoonta/all'
    end
  end

  get '/join' do
    authorized?
    erb :join_hoonta
  end
  post '/join' do
    authorized?
    user = current_user
    user.hoonta_id = params[:hoonta_id]
    redirect '/hoonta/home'
  end

  get '/create' do
    authorized?
    erb :create_hoonta
  end
  post '/create' do
    authorized?
    if params[:hoonta_name].length < 3
      set_message "Hoonta name must be three or more characters long.", 'error'
      redirect '/hoonta/create'

    elsif params[:enable_password] and params[:hoonta_password].length < 4
      set_message 'Password must be four or more characters long.', 'error'
      redirect '/hoonta/create'

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

end
