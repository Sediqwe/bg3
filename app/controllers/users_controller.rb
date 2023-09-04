class UsersController < ApplicationController
  before_action :authorized?, only: %i[new edit update destroy show index]
  def index
    @user = User.find(current_user.id)
  end
  # PATCH/PUT /lines/1
  def update
    if users_params[:password] == users_params[:password_confirmation]
      @user = User.find(current_user.id)
      if @user.update(users_params)
        redirect_to logout_path, notice: "User was successfully updated.", status: :see_other
      else
        redirect_to users_path, notice: "Hiba történt", status: :see_other
      end
    else
      redirect_to users_path, notice: "Nem azonos a 2 jelszó.", status: :see_other
    end
  end
  private
  
  # Only allow a list of trusted parameters through.
  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
