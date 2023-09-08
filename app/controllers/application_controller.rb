class ApplicationController < ActionController::Base
  add_flash_types :info, :error, :success
    helper_method :current_user
    include LogHelper
    def current_user      
        if session[:user_id]
          @current_user ||= User.find(session[:user_id])
        else
          @current_user = nil
        end
      end
    private
    def authorized?
      return if current_user.present?
      flash[:error] = 'Előbb lépj be!.'
      redirect_to login_url
    end
    def admin?
      current_user.present? && current_user.usertype == 1
    end
end
