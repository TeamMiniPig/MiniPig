class IdeaController < ApplicationController

  def idea_exists? idea_name, topic_id
    Idea.find_by(idea_name: idea_name, topic_id: topic_id)
  end

  def user_already_has_idea? user_id, topic_id
    Idea.find_by(user_id: user_id, topic_id: topic_id)
  end

  # Coming from the "create idea" form at the bottom of the topic view
  post '/' do
    authorized?

    # ideas are always downcase
    params[:idea_name] = params[:idea_name].downcase

    # If someone suggests an existing idea, add to its votes instead of creating
    # a new one.
    idea = idea_exists? params[:idea_name], params[:topic_id]
    if idea
      # Try to vote on this idea
      vote params[:user_id], idea.id

    else

      # So the idea doesn't already exist. Does this user already have an idea?
      # If they do, destroy their idea and replace it with a new one
      # And create a new idea.
      idea = user_already_has_idea? params[:user_id], params[:topic_id]

      if idea
        idea.destroy
      end

      idea = Idea.create(params)
    end

    # Done
    redirect "/topic?id=#{idea.topic_id}"
  end

end
