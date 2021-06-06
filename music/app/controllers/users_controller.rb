class UsersController < ApplicationController

    def new
        @user ||= User.new
        redirect_to user_url(current_user) if logged_in?
        render :new if !logged_in?
    end

    def create
        @user = User.new(user_params)
        if @user && @user.save
            login!
            redirect_to user_url(@user)
        else
            flash.now[:errors] = @user.errors.full_messages
            render :new
        end
    end

    def index
        render :index
    end

    def show
        @user = User.find_by(id: params[:id])
        render :show
    end


    def user_params
        params.require(:user).permit(:email, :password)
    end


    
end