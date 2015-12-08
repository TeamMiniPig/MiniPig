class TopicController < ApplicationController


    get '/' do
      authorized?
      redirect '/topic'
    end

    get '/topic' do
      authorized?
      erb :topic
    end

    get '/create' do
      authorized?
      erb :create_topic
    end
    post '/create' do
      authorized?

    end

    get '/delete' do
      authorized?
      erb :delete_topic
    end
    post '/delete' do
      authorized?
      redirect '/hoonta_home'
    end

    get '/vote' do
      authorized?
      erb :topic
    end
    post '/vote' do
      authorized?
      redirect '/topic'
    end
end
