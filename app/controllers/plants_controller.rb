class PlantsController < ApplicationController

  get "/plants" do
    redirect_if_not_logged_in
    @plants = Plant.all
      erb :"plants/index"
  end

  get "/plants/new" do
    redirect_if_not_logged_in
      erb :"plants/new"
  end

  post '/plants' do
    redirect_if_not_logged_in
    @plant = Plant.create(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed])
    @plant.user_id = current_user.id
    @plant.save
      if @plant.valid?
        redirect "/plants/#{@plant.id}"
      else
        redirect "/plants/new"
      end
  end

  get '/plants/:id' do
    redirect_if_not_logged_in
    @plant = Plant.find_by_id(params[:id])
      erb :'plants/show'
  end

  get '/plants/:id/edit' do
    redirect_if_not_logged_in
    @plant = Plant.find_by_id(params[:id])
      if current_user.id == @plant.user_id.to_i
        erb :'plants/edit'
      else
        redirect "/plants"
    end
  end

  patch '/plants/:id' do
    redirect_if_not_logged_in
    @plant = Plant.find_by_id(params[:id])
    if current_user.id == @plant.user_id
      @plant.update(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed])
      @plant.save
      redirect "/plants/#{@plant.id}"
      else
        redirect "/plants"
    end
  end

  delete '/plants/:id/delete' do
    redirect_if_not_logged_in
    @plant = Plant.find_by_id(params[:id])
      if current_user.id == @plant.user_id
        @plant.delete
        redirect "/plants"
        else
          redirect "/plants"
      end
  end

end
