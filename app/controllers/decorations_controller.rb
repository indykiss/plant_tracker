class DecorationsController < ApplicationController

  get "/decorations" do
    redirect_if_not_logged_in
    @decorations = Decoration.all
      erb :"decorations/index"
  end

  get "/decorations/new" do
    redirect_if_not_logged_in
      erb :"decorations/new"
  end

  post '/decorations' do
    redirect_if_not_logged_in
    @decoration = Decoration.create(dec_name: params[:dec_name], color: params[:color], plant_id: params[:plant_id])
    @decoration.save
      if @decoration.valid?
        redirect "/decorations/#{@decoration.id}"
      else
        redirect "/decoration/new"
      end
  end

  get '/decorations/:id' do
    redirect_if_not_logged_in
    @decoration = Decoration.find_by_id(params[:id])
      erb :'decorations/show'
  end

  get '/decorations/:id/edit' do
    redirect_if_not_logged_in
    @decoration = Decoration.find_by_id(params[:id])
      erb :'decorations/edit'
  end

  patch '/decorations/:id' do
    redirect_if_not_logged_in
    @decoration = Decoration.find_by_id(params[:id])
    @decoration.update(dec_name: params[:dec_name], color: params[:color], plant_id: params[:plant_id])
      redirect "/decorations/#{@decoration.id}"
  end

  delete '/decorations/:id/delete' do
    redirect_if_not_logged_in
    @decoration = Decoration.find_by_id(params[:id])
    @decoration.delete
      redirect "/decorations"
  end

end
