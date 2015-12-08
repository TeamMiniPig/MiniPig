class TopicController < ApplicationController


    get '/' do
      authorized?
      redirect '/topic/home'
    end

    get '/home' do
      authorized?
      erb :topic
    end

    get '/create' do
      authorized?
      erb :create_topic
    end

    get '/delete' do
      authorized?
      erb :delete_topic
    end
    post '/vote' do
      authorized?
      redirect '/topic_vote'
    end

end
