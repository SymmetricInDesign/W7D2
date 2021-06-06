class ApplicationController < ActionController::Base

    helper_method :current_user

    def login!
        session[:session_token] = @user.reset_session_token!
        @user.save
    end

    def logout!
        @user.reset_session_token!
        @user.save
        session[:session_token] = nil
    end

    def current_user
        @current_user ||= User.find_by(session_token: session[:session_token])
    end

    def logged_in?
        !!current_user
    end

    # def ensure_logged_in
    #     if !logged_in?

    #     end
    # end

end
