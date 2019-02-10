class PlantsController < ApplicationController

  get "/plants" do
    if logged_in?
      @plants = Plant.all
      erb :"/plants/index"
    else
      redirect "/login"
    end
  end

  get "/plants/new" do
    if logged_in?
      erb :"/plants/new"
     else
      redirect "/login"
    end
  end

   post '/plants' do
      if logged_in? && params[:plant][:name] != ""
        @plant = Plant.create(params[:plant])
        @plant.user = current_user
        @plant.save
        redirect "/plants/#{@plant.id}"
      elsif logged_in? && params[:plant][:name] == ""
        redirect "/plants/new"
      else
        redirect "/login"
      end
    end

  get '/plants/:id' do
    if logged_in?
      @plant = Plant.find_by_id(params[:id])
      erb :'/plants/show'
    else
      redirect "/login"
    end
  end

  get '/plants/:id/edit' do
    @plant = Plant.find_by_id(params[:id])
    if logged_in? && @plant.user == current_user
      erb :'/plants/edit_tweet'
    elsif logged_in? && @plant.user != current_user
      redirect "/plants"
    else
      redirect "/login"
    end
  end

  patch '/plants/:id' do
    @plant = Plant.find_by_id(params[:id])
    if params[:plant][:name] != ""
      @plant.update(params[:plant])
      redirect "/plants/#{@tweet.id}"
    elsif params[:plant][:name] == ""
      redirect "/plants/#{@plant.id}/edit"
    end
  end

  delete '/plants/:id/delete' do
    @plant = Plant.find_by_id(params[:id])
    if logged_in? && @plant.user == current_user
      @plant.delete
      redirect "/plants"
    else
      redirect "/login"
    end
  end


end