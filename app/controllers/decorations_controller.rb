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

  post '/decorations' do
    @decoration = Decoration.create(dec_name: params[:dec_name], color: params[:color])
    erb :'decorations/show'
  end

  get '/decorations/:id' do
    if logged_in?
      @decoration = Decoration.find(params[:id])
      binding.pry
      erb :'decorations/show'
    else
      redirect "/login"
    end
  end

  get '/decorations/:id/edit' do
    if logged_in?
      @decoration = Decoration.find(params[:id])

        erb :'decorations/edit'
#    elsif logged_in? && @plant.user != current_user
#      redirect "/decorations"
    else
      redirect "/login"
    end
  end

  post '/decorations/:id' do
    if logged_in?
    @decoration = Decoration.find(params[:id])

    @decoration.update(params.select{|k|k=="dec_name" || k=="color"})
    redirect "/decorations/#{@decoration.id}"

  #    if logged_in? && params[:plant][:name] != ""
  #      @plant = Plant.create(name: params[:name], water_needed: params[:water_needed], light_needed: params[:light_needed])
  #      @plant.user = current_user
  #      @plant.save
  #      redirect "/decorations/#{@plant.id}"
  #    elsif logged_in? && params[:plant][:name] == ""
  #      redirect "/decorations/#{@plant.id}"

      else
        redirect "/login"
      end
  end

  patch '/decorations/:id' do
    @decoration = Decoration.find(params[:id])
  #  if params[:plant][:name] != ""
      @decoration.update(dec_name: params[:dec_name], color: params[:color])
      redirect "/decorations/#{@decoration.id}"
  #  elsif params[:plant][:name] == ""
  #    redirect "/decorations/#{@plant.id}/edit"
  #  end
  end

  get '/decorations/:id/delete' do
    if logged_in?
      @decoration = Decoration.find_by(params[:id])
      @decoration.delete
      redirect "/decorations"
    else
      redirect "/login"
    end
  end


end
