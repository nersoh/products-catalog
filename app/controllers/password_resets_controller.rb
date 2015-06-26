class PasswordResetsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by_email(params[:password_reset][:email])
  	if user
  		user.send_password_reset
  		flash[:info] = 'Instructions for password reset has been sent'
      redirect_to root_url
  	else
  		flash[:danger] = 'Email not found in our records'
  		render 'new'
  	end
  end

  def edit
  	@user = User.find_by!(password_reset_token: params[:id])
  end

  def update
    @user = User.find_by(password_reset_token: params[:id])
    if @user && @user.password_reset_sent_at < 2.hours.ago
      flash[:warning] = "Password reset has expired"
      render 'edit'
    elsif @user.update_attributes(user_params)
      flash[:success] = "Password has been reset"
      redirect_to login_url
    else
      render 'edit'
    end
  end

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
