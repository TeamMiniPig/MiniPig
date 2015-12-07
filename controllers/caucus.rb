class CaucusController < ApplicationController

  get '/' do
    authorized?
    redirect '/caucus/home'
  end

  get '/home' do
    authorized?
    erb :caucus_home
  end

  get '/join' do
    authorized?
    erb :join_caucus
  end
  post '/join' do
    authorized?
    session[:current_user].caucus_id = params[:caucus_id]
    redirect '/caucus/home'
  end

  get '/create' do
    authorized?
    erb :create_caucus
  end
  post '/create' do
    authorized?
    if params[:caucus_name].length < 3
      set_message "Caucus name must be three or more characters long.", 'error'
      return redirect '/caucus/create'

    elsif params[:enable_password] and params[:caucus_password].length < 4
      set_message 'Password must be four or more characters long.', 'error'
      return redirect '/caucus/create'

    else
      if not params[:enable_password]
        params[:caucus_password] = '';
      end
      @caucus = Caucus.create(caucus_name: params[:caucus_name],
                              has_password: params[:enable_password].nil?,
                              caucus_password: params[:caucus_password])
      session[:current_user].caucus_id = @caucus.id
      session[:current_user].save
      set_message 'Caucus created.', "success"
      redirect '/caucus/home'
    end
  end

end
