class FiguresController < ApplicationController

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'../views/figures/new'
  end

  post '/figures/new' do
    binding.pry
    @figure = Figure.new(name: params["figure"]["name"])
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'../views/figures/show'
  end

  patch '/figures/:id' do
    @figure = Figure.find#("primary key")
    @figure.name = params["figure"]["name"]
    @figure.save
    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
  
  end
end
