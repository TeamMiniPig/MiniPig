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
      topic = params[:topic]
      if Topic.find_by(topic_name: topic[:topic_name])
        set_message "Topic already exists.", "error"
        redirect '/hoonta/home'
      else
        category = Category.find_by(category_name: topic[:category])
        if not category
          category = Category.create(category_name: topic[:category])
        end
        new_topic = Topic.create(topic_name: topic[:topic_name],
                                   category_id: category.id,
                                   deadline: topic[:deadline],
                                   hoonta_id: get_hoonta.id)
        set_message "Topic created.", "success"
        redirect '/hoonta/home'

      end

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
