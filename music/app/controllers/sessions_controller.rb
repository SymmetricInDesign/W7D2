class SessionsController < ApplicationController


    def new
        @user ||= User.new
        redirect_to user_url(current_user) if logged_in?
        render :new if !logged_in?
    end

    def create
        @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
        if @user && @user.save
            login!
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def destroy
        @user = current_user
        logout! if @user
        redirect_to users_url
    end

    
end