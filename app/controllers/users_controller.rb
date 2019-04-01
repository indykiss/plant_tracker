class UsersController < ApplicationController

  get "/signup" do
    redirect_if_not_logged_in
      redirect "/plants"
  end

  post "/signup" do
    # fix me. redirecting to plants and then login when duplicate email
    redirect_if_not_logged_in
    @user = User.new(params)
    @user.save
      session[:user_id] = user.id
      redirect "/plants"
  end

  get "/login" do
    redirect_if_not_logged_in
      redirect "/plants"
  end

  post "/login" do
    #maybe problematic
    redirect_if_not_logged_in
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
        session[:user_id] = @user.id
      redirect "/plants"
    end
  end

  get '/logout' do
    #maybe not done?
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect "/signup"
    end
  end

end
