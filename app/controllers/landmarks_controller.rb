class LandmarksController < ApplicationController
  get '/landmarks' do 
    @all_landmarks = Landmark.all
    erb :'../views/landmarks/index'
  end

  get '/landmarks/:id' do
    @landmarks = Landmark.find(params[:id])
    erb :'../views/landmarks/show'
  end

  get '/landmarks/:id/edit' do
    
  end

  patch '/landmarks/:id' do

  end


end
