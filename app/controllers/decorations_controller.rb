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
    if logged_in?
      @decoration.create(dec_name: params[:dec_name], color: params[:color])
      @decoration.user_id = current_user.id
      @decoration.save
      redirect "/decorations/#{@decoration.id}"
    else
      redirect "/login"
    end
  end

  get '/decorations/:id' do
    @decoration = Decoration.find_by_id(params[:id])
    if logged_in?
      erb :'decorations/show'
    else
      redirect "/login"
    end
  end

  get '/decorations/:id/edit' do
    @decoration = Decoration.find_by_id(params[:id])
    if logged_in?
        erb :'decorations/edit'
    else
      redirect "/login"
    end
  end

  post '/decorations/:id' do
    @decoration = Decoration.find(params[:id])
    if logged_in?
    redirect "/decorations/#{@decoration.id}"
      else
        redirect "/login"
      end
  end

  patch '/decorations/:id' do
    @decoration = Decoration.find(params[:id])
      @decoration.update(dec_name: params[:dec_name], color: params[:color], plant_id: params[:plants_id])
      redirect "/decorations/#{@decoration.id}"
  end

  get '/decorations/:id/delete' do
    @decoration = Decoration.find(params[:id])
    if logged_in?
      @decoration.delete
      redirect "/decorations"
    else
      redirect "/login"
    end
  end


end
