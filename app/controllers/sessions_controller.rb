class SessionsController < ApplicationController
  skip_before_action :require_login, except: [:destroy]

  def new
    if current_user
      redirect_to "/users/#{current_user.id}"
    end
    # Render login page
  end

  def create
    user = User.find_by_email(user_params[:email]).try(:authenticate, user_params[:password])
    if user
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}"
    else
      redirect_to "/sessions/new"
      flash[:errors] = "Invalid Combination"
    end
  end

  def destroy
    reset_session
    redirect_to "/sessions/new"
  end

  private 
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
