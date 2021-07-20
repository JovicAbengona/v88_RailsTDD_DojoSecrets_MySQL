class ApplicationController < ActionController::Base
    before_action :require_login

    def current_user
        User.find(session[:user_id]) if session[:user_id]
    end
    helper_method :current_user

    private 
        def require_login
            if !current_user
                redirect_to "/sessions/new"
            end
        end
end
