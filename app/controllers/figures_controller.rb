class FiguresController < ApplicationController

  get '/figures' do 
    @all_figs = Figure.all
    erb :'../views/figures/index'
  end

  get '/figures/new' do
    @landmarks = Landmark.all
    @titles = Title.all
    erb :'../views/figures/new'
  end

  post '/figures' do
    @figure = Figure.create(name: params["figure"]["name"])
    if !params["landmark"]["name"].empty? # if they make a new landmark
      @landmark = Landmark.create(name: params["landmark"]["name"], figure_id: @figure.id, year_completed: params["landmark"]["year_completed"])
    else
      Landmark.find(params["figure"]["landmark_ids"][0]).update(figure_id: @figure.id)
    end

    if !params["title"]["name"].empty? # if they make a new title
      @title = Title.create(name: params["title"]["name"])
    else
      @title = Title.find(params["figure"]["title_ids"])[0]
    end

    @fig_title = FigureTitle.create(figure_id: @figure.id, title_id: @title.id)
    redirect "/figures/#{@figure.id}"
  end

  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'../views/figures/show'
  end

  get '/figures/:id/edit' do
    @landmarks = Landmark.all
    @titles = Title.all
    @figure = Figure.find(params["id"])
    erb :'../views/figures/edit'
  end

  patch '/figures/:id' do
    if !params["figure"].keys.include?("title_ids")
      params["figure"]["title_ids"] = []
    elsif !params["figure"].keys.include?("landmark_ids")
      params["figure"]["landmark_ids"] = []
    elsif !params["figure"].keys.include?("title_ids") && !params["figure"].keys.include?("landmark_ids")
      params["figure"]["title_ids"] = []
      params["figure"]["landmark_ids"] = []
    end
    
    @figure = Figure.find(params["id"])
    # @figure.update(
    if !params["landmark"]["name"].empty?
      @figure.landmarks << Landmark.create(name: params["landmark"]["name"], figure_id: @figure.id, year_completed: params["landmark"]["year_completed"])
    elsif !params["title"]["name"].empty?
      @figure.titles << Title.create(name: params["title"]["name"])
    elsif !params["figure"]["name"].empty?
      @figure.name = params["figure"]["name"]
    end

    redirect "/figures/#{@figure.id}"
  end

  delete '/figures/:id' do
    @figure = Figure.find(params[:id])
    @figure.delete
  end
end
