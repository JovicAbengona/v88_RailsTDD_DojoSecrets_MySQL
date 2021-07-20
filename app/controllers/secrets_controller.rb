class SecretsController < ApplicationController
  def index
    # For some reason, COUNT(likes.*) does not work
    @secrets = Secret.left_joins(:likes).select("secrets.*", "COUNT(likes.id) AS num_of_likes").group("secrets.id").order("secrets.id ASC")
  end

  def create
    secret = Secret.new(content: params[:content], user: User.find(params[:id]))
    if !secret.save
      flash[:errors] = secret.errors.messages
    end
    redirect_to "/users/#{params[:id]}"
  end

  def delete
    secret = Secret.find(params[:id])
    if session[:user_id] == secret[:user_id]
      if !secret.destroy
        flash[:error] = "An error has occured!"
        redirect_to "/users/#{session[:user_id]}"
      else
        redirect_to "/users/#{session[:user_id]}"
      end
    else
      render :file => "public/401.html", :status => 401
    end
  end
end
