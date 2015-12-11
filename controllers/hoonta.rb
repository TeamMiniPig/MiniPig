class HoontaController < ApplicationController

  get '/' do
    authorized?
    redirect '/hoonta/all'
  end

  get '/all' do
    authorized?
    @rosters = Roster.where(user_id: current_user.id)
    erb :hoonta_landing
  end

  get '/home/:id' do
    authorized?
    @hoonta  = Hoonta.find(params[:id])
    @rosters = Roster.where(hoonta_id: @hoonta.id)
    @topics  = Topic.where(hoonta_id: @hoonta.id)
    erb :hoonta_home
  end

  post '/edit/:id' do
    authorized?
    @hoonta = Hoonta.find(params[:id])
    @rosters = Roster.where(hoonta_id: @hoonta.id)
    @topics = Topic.where(hoonta_id: @hoonta.id)
    new_name = params[:new_name]
    if Hoonta.find_by(hoonta_name: new_name.downcase)
      set_message "That Hoonta name is already taken.", "error"
    else
      @hoonta.hoonta_name = new_name
      @hoonta.save
      set_message "Hoonta name changed.", "success"
    end
    redirect "/hoonta/home/#{@hoonta.id}"
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
          redirect "/hoonta/home/#{hoonta.id}"

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

    # Catch name collision
    if Hoonta.find_by(hoonta_name: params[:hoonta_name])
      set_message "Hoonta already exists.", 'error'
      erb :create_hoonta

    # Catch invalid name
    elsif params[:hoonta_name].length < 3
      set_message "Hoonta name must be three or more characters long.", 'error'
      erb :create_hoonta

    # Catch invalid password
    elsif params[:enable_password] and params[:hoonta_password].length < 4
      set_message 'Password must be four or more characters long.', 'error'
      erb :create_hoonta

    # Otherwise they're good to go
    else
      if not params[:enable_password]
        params[:hoonta_password] = nil;
      end

      hoonta = Hoonta.create(hoonta_name:     params[:hoonta_name],
                             hoonta_password: params[:hoonta_password],
                             user_id:         session[:current_user])

      set_message 'Hoonta created.', 'success'
      Roster.create(user_id: session[:current_user], hoonta_id: hoonta.id)

      redirect "/hoonta/home/#{hoonta.id}"
    end
  end

  get '/leave/:id' do
    Roster.find_by(user_id: current_user.id, hoonta_id: params[:id]).destroy
    redirect '/hoonta/all'
  end


end
