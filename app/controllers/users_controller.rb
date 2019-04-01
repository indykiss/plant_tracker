class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect "/plants"
    else
    erb :"/users/signup"
   end
  end

  post "/signup" do
  # fix me. redirecting to plants and then login when duplicate email 
    @user = User.new(params)
    if user.save
        session[:user_id] = user.id
        redirect "/plants"
    else
        redirect "/signup"
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
    @user = User.find_by(email: params[:email])
      if @user && @user.authenticate(params[:password])
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
