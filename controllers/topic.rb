class TopicController < ApplicationController


  get '/:id' do
    authorized?
    @topic  = Topic.find(params[:id])
    @hoonta = Hoonta.find(@topic.hoonta_id)
    @ideas  = Idea.where(topic_id: params[:id])
    erb :topic
  end

  get '/create/:hoonta_id' do
    authorized?
    @hoonta = Hoonta.find(params[:hoonta_id])
    erb :create_topic
  end

  post '/create/:hoonta_id' do
    authorized?
    params[:topic_name] = params[:topic_name].downcase

    # If the topic already exists, don't create it
    if Topic.find_by(topic_name: params[:topic_name],
                     hoonta_id:  params[:hoonta_id])

      set_message "Topic already exists.", "error"

    # If it's new, create it
    else
      Topic.create(topic_name: params[:topic_name],
                   deadline:   params[:deadline],
                   hoonta_id:  params[:hoonta_id],
                   user_id:    session[:current_user])

      set_message "Topic created.", "success"

    end

    redirect "/hoonta/home/#{params[:hoonta_id]}"
  end

  post '/edit/:id' do
    authorized?
    @topic = Topic.find(params[:id])
    @hoonta = Hoonta.find(@topic.hoonta_id)
    @ideas = Idea.where(topic_id: @topic.id)
    new_name = params[:new_name].downcase

    # Name collision error. Changing capitalization is okay
    if @topic.topic_name != new_name and
       Topic.find_by(topic_name: new_name, hoonta_id: @topic.hoonta_id)

      set_message "That topic already exists.", "error"

    # Good to go
    else
      @topic.topic_name = new_name
      @topic.save
      set_message "Topic name changed.", "success"
    end
    redirect "/topic/#{@topic.id}"
  end


  post '/delete_topic/:id' do
    topic  = Topic.find(params[:id])
    ideas = Idea.where(topic_id: topic.id)

    # delete all associated ideas and votes
    if not ideas.empty?
      ideas.each do |idea|

        votes = Vote.where(idea_id: idea.id)
        if not votes.empty?
          votes.each do |vote|
            vote.destroy
          end
        end

        idea.destroy
      end
    end

    hoonta = topic.hoonta_id
    topic.destroy
    redirect "/hoonta/home/#{hoonta}"
  end


end
