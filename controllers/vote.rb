class VoteController < ApplicationController
  post '/' do
    authorized?
    vote params[:user_id], params[:idea_id]
    redirect "/topic?id=#{params[:topic_id]}"
  end
end
