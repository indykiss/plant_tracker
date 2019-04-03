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
    if params[:name] && params[:password] && params[:email]
      @user = User.create(params)
      session[:user_id] = @user.id
        redirect "/plants"
    else
      redirect '/signup'
    end
  end

#  post "/signup" do
    # fix me. redirecting to plants and then login when duplicate email
#    @user = User.new(params)
#    @user.save
#      session[:user_id] = @user.id
#      redirect "/plants"
#  end

  get "/login" do
    redirect_if_not_logged_in
      redirect "/plants"
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
    #maybe not done?
    if logged_in?
      session.clear
      redirect '/login'
    else
      redirect "/signup"
    end
  end

end
