class HoontaController < ApplicationController

  get '/' do
    authorized?
    redirect '/hoonta/home'
  end

  get '/home' do
    authorized?
    erb :hoonta_home
  end

  get '/join' do
    authorized?
    erb :join_hoonta
  end
  post '/join' do
    authorized?
    session[:current_user].hoonta_id = params[:hoonta_id]
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
      return redirect '/hoonta/create'

    elsif params[:enable_password] and params[:hoonta_password].length < 4
      set_message 'Password must be four or more characters long.', 'error'
      return redirect '/hoonta/create'

    else
      if not params[:enable_password]
        params[:hoonta_password] = '';
      end
      @hoonta = Hoonta.create(hoonta_name: params[:hoonta_name],
                              has_password: params[:enable_password].nil?,
                              hoonta_password: params[:hoonta_password])
      session[:current_user].hoonta_id = @hoonta.id
      session[:current_user].save
      set_message 'Hoonta created.', "success"
      redirect '/hoonta/home'
    end
  end

end
