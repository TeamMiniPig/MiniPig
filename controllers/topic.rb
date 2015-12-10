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
<<<<<<< HEAD
                   user_id:    session[:current_user])
=======
                     user_id:  session[:current_user])
>>>>>>> fe0544cdfad24e32e42c5155d41daa09f9d27d58
      set_message "Topic created.", "success"

    end

    redirect "/hoonta/home/#{params[:hoonta_id]}"
  end


  post '/delete_topic/:id' do
    topic= Topic.find(params[:id])
    hoonta= topic.hoonta_id
    topic.destroy
    redirect "/hoonta/home/#{hoonta}"
  end


end
