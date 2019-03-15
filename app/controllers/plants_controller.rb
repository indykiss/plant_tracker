class PlantsController < ApplicationController

  get "/plants" do
    if logged_in?
      @plants = Plant.all
      erb :"plants/index"
    else
      redirect "/login"
    end
  end

  get "/plants/new" do
    if logged_in?
      erb :"plants/new"
     else
      redirect "/login"
    end
  end

  post '/plants' do
    @plant = Plant.create(params)
    erb :'plants/show'
  end

  get '/plants/:id' do
    @plant = Plant.find(params[:id])
    if logged_in?
      erb :'plants/show'
    else
      redirect "/login"
    end
  end

  get '/plants/:id/edit' do
    @plant = Plant.find(params[:id])
    binding.pry

    if logged_in? && current_user.id == @plant.user_id
      erb :'plants/edit'
    elsif logged_in? && current_user.id != @plant.user_id
      redirect "/plants"
    else
      redirect "/login"
    end
  end

  post '/plants/:id' do
    @plant = Plant.find(params[:id])

    if logged_in? && current_user.id == @plant.user_id

    @plant.update(params.select{|k|k=="name" || k=="water_needed" || k=="light_needed"})
    redirect "/plants/#{@plant.id}"

  elsif logged_in? && current_user.id != @plant.user_id
      redirect "/plants"
    else
      redirect "/login"
    end
  end
  # nested if statement, if not the right user
  # then we need to redirect to /plants index

  #    if logged_in? && params[:plant][:name] != ""
  #      @plant = Plant.create(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed])
  #      @plant.user = current_user
  #      @plant.save
  #      redirect "/plants/#{@plant.id}"
  #    elsif logged_in? && params[:plant][:name] == ""
  #      redirect "/plants/#{@plant.id}"


  patch '/plants/:id' do
    @plant = Plant.find(params[:id])
  #  if params[:plant][:name] != ""
      @plant.update(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed] )
      redirect "/plants/#{@plant.id}"
  #  elsif params[:plant][:name] == ""
  #    redirect "/plants/#{@plant.id}/edit"
  #  end
  end

  get '/plants/:id/delete' do
    @plant = Plant.find_by(params[:id])

    if logged_in? && current_user.id == @plant.user_id
      @plant.delete
      redirect "/plants"
    elsif logged_in? && current_user.id != @plant.user_id
      redirect "/plants"
    else
      redirect "/login"
    end
  end


end
