class VoteController < ApplicationController
  post '/:user_id/:topic_id/:idea_id' do
    authorized?
    vote params[:user_id], params[:idea_id]
    redirect "/topic/#{params[:topic_id]}"
  end
end
