class SessionsController < ApplicationController
  def new
    
  end

  def create
    user = User.where(username: params[:username]).first

    if user && user.authenticate(params[:password])
      if user.two_factor_auth?
        session[:two_factor] = true
        user.generate_pin!
        user.send_pin_twilio
        redirect_to pin_path
      else        
        login_user!(user)
      end
    else
      flash[:error] = "There is something wrong with your username or password"
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out"
    redirect_to root_path
  end

  def pin
    if request.post?
      user = User.find_by pin: params[:pin]
      if user
        session[:two_factor] = nil
        user.remove_pin!
        login_user!(user)
      else
        flash[:error] = "Sorry, something is wrong with your pin number"
        redirect_to pin_path
      end
    else
      unless session[:two_factor]
        # access_denied
        flash[:error] = "Restricted area!"
        redirect_to root_path 
      end
    end
  end

  private

  def login_user!(user)
    session[:user_id] = user.id
    flash[:notice] = "Welcome, you've logged in"
    redirect_to root_path    
  end
end