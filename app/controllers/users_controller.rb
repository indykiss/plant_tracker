class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect "/plants"
    else
    erb :"/users/signup"
   end
  end

  post "/signup" do
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
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
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/plants"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    if logged_in?
      session.clear
    end
    redirect "/login"
  end

  get '/users/:slug' do
    @plants = Plant.all
    erb :'/users/show'
  end

end 


