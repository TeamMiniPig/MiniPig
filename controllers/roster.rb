class RosterController < ApplicationController
  post '/create' do
    authorized?
    Roster.create(user_id: params[:user_id], hoonta_id: params[:hoonta_id])
    redirect '/hoonta/home'
  end
end
