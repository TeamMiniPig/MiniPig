class TopicController < ApplicationController

    get '/' do
      authorized?
      session[:topic] = params[:id]
      erb :topic
    end

    get '/create' do
      authorized?
      erb :create_topic
    end
    post '/create' do
      authorized?
      topic = params[:topic]
      if Topic.find_by(topic_name: topic[:topic_name])
        set_message "Topic already exists.", "error"
        redirect '/hoonta/home'
      else

        Topic.create(topic_name: topic[:topic_name],
                     deadline: topic[:deadline],
                     hoonta_id: get_hoonta.id)
        set_message "Topic created.", "success"
        redirect '/hoonta/home'

      end

    end

    # get '/delete' do
    #   authorized?
    #   erb :delete_topic
    # end
    # destroy '/delete' do
    #   authorized?
    #   Topic.destroy
    #   redirect '/hoonta/home'
    # end

    get '/vote' do
      authorized?
      erb :topic
    end
    post '/vote' do
      authorized?
      redirect '/topic'
    end
end
