class LikesController < ApplicationController
  def create
    like = Like.new(user: User.find(session[:user_id]), secret: Secret.find(params[:id]))
    if like.save
      redirect_to "/secrets"
    else
      render plain: "An error occured!"
    end
  end

  def destroy
    like = Secret.find(params[:id]).likes.where(user: User.find(session[:user_id]))
    if like.length > 0
      if !like[0].destroy
        flash[:error] = "An error occured!"
        redirect_to "/secrets"
      else
        redirect_to "/secrets"
      end
    else
      render :file => "public/401.html", :status => 401
    end
  end
end
