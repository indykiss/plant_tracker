require './config/environment'

class DecorationsController < ApplicationController

  get "/decorations" do
    if logged_in?
      @decorations = Decoration.all
      erb :"decorations/index"
    else
      redirect "/login"
    end
  end

  get "/decorations/new" do
    if logged_in?
      erb :"decorations/new"
     else
      redirect "/login"
    end
  end

  get '/decorations/:id' do
    if logged_in?
      @decoration = Decoration.find(params[:id])
      erb :'decorations/show'
    else
      redirect "/login"
    end
  end

  get '/decorations/:id/edit' do
    if logged_in? && @decoration.user == current_user
      @decoration = Decoration.find(params[:id])
        erb :'decorations/edit'
#    elsif logged_in? && @decoration.user != current_user
#      redirect "/decorations"
    else
      redirect "/login"
    end
  end

  post '/decorations' do
    @decoration = Decoration.create(params)
    erb :'decorations/show'
    #binding.pry
  end

  post '/decorations/:id' do
      if logged_in? && params[:decoration][:dec_name] != ""
        @decoration = Decoration.create(dec_name: params[:dec_name], color: params[:color])
        @decoration.user = current_user
        @decoration.save
        redirect "/decorations/#{@decoration.id}"
      elsif logged_in? && params[:decoration][:dec_name] == ""
        redirect "/decorations/#{@decoration.id}"
      else
        redirect "/login"
      end
  end

  patch '/decorations/:id' do
    @decoration = Decoration.find(params[:id])
  #  if params[:decoration][:dec_name] != ""
      @decoration.update(params[:decoration])
      redirect "/decorations/#{@decoration.id}"
  #  elsif params[:decoration][:dec_name] == ""
  #    redirect "/decorations/#{@decoration.id}/edit"
  #  end
  end

  delete '/decorations/:id/delete' do
    @decoration = Decoration.find(params[:id])
    if logged_in? && @decoration.user == current_user
      @decoration.delete
      redirect "/decorations"
    else
      redirect "/login"
    end
  end


end
