class SessionsController < ApplicationController
    before_action :require_current_user!, except: [:destroy]

    def new
        render :new
    end

    def create
        user = User.find_by_credentials(params[:user][:user_name], params[:user][:password])

        if user
            login(user)
            redirect_to cats_url
        else
            flash.now[:errors] = ["Wrong Username/Password Combination"]
            render :new
        end
    end

    def destroy
        current_user.reset_session_token!
        session[:session_token] = nil
        redirect_to cats_url
    end
end
