class SessionController < ApplicationController
  
  def new

  end
  def create   
    user = User.find_by(name: user_params[:name].downcase).try(:authenticate, user_params[:password])
      if user
      session[:user_id] = user.id
      create_log( "Page: Sessions#Create", "User belépve. #{user.name}")
      redirect_to root_url , info: "Sikeresen belépve"
      
    else      
      flash.now[:error] = "Hibás felhasználó / jelszó páros"
      render 'new'
    end
   end
   def destroy
    session[:user_id] = nil
      redirect_to root_url, info: "Kilépve"
   end
   
   private
    def user_params
     params.require(:session).permit(:name, :password)
    end

  
end
