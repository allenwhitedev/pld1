class UsersController < ApplicationController
  
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "Welcome to the Pipeline, you can now check in to events"
			redirect_to @user
		else
			render 'new'
		end
	end
  
  def new
  	@user = User.new
  end

  def show
  	@user = User.find_by(params[:id])
  end

private
	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end


end
