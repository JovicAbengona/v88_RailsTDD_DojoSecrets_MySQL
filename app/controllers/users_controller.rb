class UsersController < ApplicationController
  skip_before_action :require_login, except: [:show, :edit, :update, :delete]
  before_action :auth_user, except: [:new, :register]

  def new
  end

  def register
    user = User.new(user_params)
    if user.save
      redirect_to "/sessions/new"
    else
      flash[:reg_name] = user_params["name"]
      flash[:reg_email] = user_params["email"]

      flash[:errors] = user.errors.messages
      if user_params[:password].length > 0 && user_params[:password].length < 8
        flash[:errors][:password] = ["should be at least 8 characters long"]
        flash[:errors][:password_confirmation] = nil
      end
      redirect_to '/users/new'
    end
  end

  def show
    @user = User.find(params[:id])
    @secrets = User.find(session[:user_id]).secrets
    @secrets_liked = User.find(session[:user_id]).secrets_liked
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])
    if user.update(user_update_params)
      redirect_to "/users/#{params[:id]}"
    else
      flash[:errors] = user.errors.messages
      redirect_to "/users/#{params[:id]}/edit"
    end
  end

  def delete
    user = User.find(params[:id])
    if user.destroy
      reset_session
      redirect_to "/users/new"
    else
      render plain: "An error occured!"
    end
  end

  private 
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end

    def user_update_params
      params.require(:user).permit(:name, :email)
    end

    def auth_user
      if session[:user_id] != params[:id].to_i
        redirect_to "/users/#{session[:user_id]}"
      end
    end
end
