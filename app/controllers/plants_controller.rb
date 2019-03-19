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
    if logged_in?
      @plant = Plant.create(params)
      erb :'plants/show'
    else
     redirect "/login"
   end
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

    if logged_in?
      # This breaks everything:
      # && current_user.id == @plant.user_id
      erb :'plants/edit'
    elsif logged_in?
      redirect "/plants"
    else
      redirect "/login"
    end
  end

  post '/plants/:id' do
    @plant = Plant.find(params[:id])

    if logged_in?
       # This breaks everything:
      # && current_user.id == @plant.user_id
    @plant.update(params.select{|k|k=="name" || k=="water_needed" || k=="light_needed"})
    redirect "/plants/#{@plant.id}"
      elsif logged_in?
        redirect "/plants"
        else
          redirect "/login"
    end
  end

  patch '/plants/:id' do
    @plant = Plant.find(params[:id])
    @plant.update(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed])
      redirect "/plants/#{@plant.id}"
  end

  get '/plants/:id/delete' do
    @plant = Plant.find_by(params[:id])

    if logged_in?
       # This breaks everything:
      # && current_user.id == @plant.user_id
      @plant.delete
      redirect "/plants"
    elsif logged_in?
      redirect "/plants"
    else
      redirect "/login"
    end
  end


end
