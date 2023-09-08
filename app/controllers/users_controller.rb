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
        redirect_to logout_path, info: "User was successfully updated.", status: :see_other
      else
        redirect_to users_path, info: "Hiba történt" + @user.errors.full_messages.join(", "), status: :see_other
      end
    else
      redirect_to users_path, info: "Nem azonos a 2 jelszó.", status: :see_other
    end
  end

  def new
    @user = User.new
  end
  def destroy
    user = User.find(params[:id])
    create_log( "Page: User#Destroy", "User törölve. #{user.name}")
    user.destroy
    redirect_to userslist_url, info: "User was successfully destroyed.", status: :see_other
  end
  def inaktiv
  end
  def aktiv
  end 
  def create
    @user = User.new(users_params )
    @user.name = users_params[:name].downcase
    @user.usertype = 2
    @user.admin = false
    if @user.save
      redirect_to userslist_path, notice: "User was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end
  def userslist
    @userslist = User.all
  end

  private
  
  # Only allow a list of trusted parameters through.
  def users_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
