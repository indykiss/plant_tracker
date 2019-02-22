class PlantsController < ApplicationController

  get "/plants" do
  #  if logged_in?
      @plants = Plant.all
      erb :"plants/index"
#    else
#      redirect "/login"
#    end
  end

  get "/plants/new" do
    #if logged_in?
      erb :"plants/new"
     #else
      #redirect "/login"
    #end
  end

  post '/plants' do
    @plant = Plant.create(params[:name])
    erb :'plants/show'
  end

  get '/plants/:id/edit' do
    @plant = Plant.find(params[:id])
  #  if logged_in? && @plant.user == current_user
      erb :'plants/edit'
#    elsif logged_in? && @plant.user != current_user
#      redirect "/plants"
#    else
#      redirect "/login"
#    end
  end

   post '/plants/:id' do
  #    if logged_in? && params[:plant][:name] != ""
        @plant = Plant.create(params[:name])
        @plant.user = current_user
        @plant.save
        redirect "/plants/#{@plant.id}"
  #    elsif logged_in? && params[:plant][:name] == ""
  #      redirect "/plants/new"
  #    else
  #      redirect "/login"
  #    end
    end

  get '/plants/:id' do
  #  if logged_in?
      @plant = Plant.find(params[:id])
      erb :'plants/show'
#    else
#      redirect "/login"
#    end
  end

  patch '/plants/:id' do
    @plant = Plant.find(params[:id])
  #  if params[:plant][:name] != ""
      @plant.update(params[:plant])
      redirect "/plants/#{@plant.id}"
  #  elsif params[:plant][:name] == ""
  #    redirect "/plants/#{@plant.id}/edit"
  #  end
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
