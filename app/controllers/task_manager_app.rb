require_relative '../models/task.rb'

class TaskManagerApp < Sinatra::Base
  set :root, File.expand_path("..", __dir__)

  get '/' do
    erb :dashboard
    #erb is templating language
  end

  get '/tasks' do
    @tasks = Task.all
    erb :index
  end

  get '/tasks/new' do
    erb :new
  end

  get '/tasks/:id' do
    @task = Task.find(params[:id])
    erb :show
  end

  get '/tasks/:id/edit' do
    @task = Task.find(params[:id])
    erb :edit
  end

  set :method_override, true
  # ...
  put '/tasks/:id' do |id|
    Task.update(id.to_i, params[:task])
    redirect "/tasks/#{id}"
  end

  delete '/tasks/:id' do |id|
    Task.destroy(id.to_i)
    redirect '/tasks'
  end

  post '/tasks' do
    task = Task.new(params[:task])
    task.save
    redirect '/tasks'
  end
end
