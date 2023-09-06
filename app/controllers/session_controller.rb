class SessionController < ApplicationController
  def new

  end
  def create   
    user = User.find_by(name: user_params[:name].downcase).try(:authenticate, user_params[:password])
    p user_params[:name]
    p user_params[:password]
    p user.inspect
    if user
      session[:user_id] = user.id
      redirect_to root_url, notice: "Belépve!"
    else
      
      flash.now[:login_error] = "Hibás felhasználó / jelszó páros"
      render 'new'
    end
   end
   def destroy
    session[:user_id] = nil
      redirect_to root_url, notice: "Kilépve"
   end
   
   private
    def user_params
     params.require(:session).permit(:name, :password)
    end

  
end
