require 'pry'
class FiguresController < ApplicationController

  get '/figures' do
    @figures = Figure.all
    erb :'/figures/index'
  end

  get '/figures/new' do
    @titles = Title.all
    @landmarks = Landmark.all
    erb :'figures/new'
  end


  get '/figures/:id' do
    @figure = Figure.find(params[:id])
    erb :'/figures/show'
  end

  get '/figures/:id/edit' do
    @titles = Title.all
    @landmarks = Landmark.all
    @figure = Figure.find(params[:id])
    erb :'/figures/edit'
  end

  post '/figures/:id' do #updating params
    @figure = Figure.find(params[:id])
    @figure.update(params[:figure])

    if !params[:title][:name].empty
      @figure.titles << Title.create(params[:title])
    end

    if !params[:landmark][:name].empty?
      @figure.landmarks << Landmark.create(params[:landmark])
    end

    erb :'/figures/{@figure.id}'
  end

  post '/figures' do
    @new_figure = Figure.create(params[:figure])


    if !params["title"]["name"].empty?
      @new_title = Title.create(params["title"])
      @new_figure.titles << @new_title
    end

    if !params[:landmark][:name].empty?
      @new_landmark = Landmark.create(params[:landmark])
      @new_figure.landmarks << @new_landmark
    end

    @new_figure.save
    redirect '/figures/new'
  end

end
