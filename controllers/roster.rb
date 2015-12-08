class RosterController < ApplicationController
  get '/create' do
    authorized?
    Roster.create(user_id: params[:user_id], hoonta_id: params[:hoonta_id])
    redirect '/hoonta/home'
  end
end
