class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect "/plants"
    else
    erb :"/users/signup"
   end
  end

  post "/signup" do
    if params[:name] && params[:password] && params[:email]
      @user = User.create(params)
      session[:user_id] = @user.id
        redirect "/plants"
    else
      redirect '/signup'
    end
  end

  get "/login" do
    if logged_in?
      redirect "/plants"
    else
      erb :"/users/login"
    end
  end

  post "/login" do
    @user = User.find_by(name: params[:name])
      if @user && @user.authenticate(params[:password]) && @user.authenticate(params[:email])
        session[:user_id] = @user.id
      redirect "/plants"
      else
        redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect "/signup"
    end
  end

end
