class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :index, :destroy, :attending]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: [:destroy]

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

	def destroy
		User.find(params[:id]).destroy
		flash[:success] = "User deleted"
		redirect_to users_url
	end
  
	def edit
	end

	def update
		@user = User.find(params[:id])
		if @user.update_attributes(user_params)
			flash[:success] = "Profile Updated"
			redirect_to @user
		else
			render 'edit'
		end
	end

  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  	@events = @user.events.paginate(page: params[:page])
  end

  def index
  	@users = User.paginate(page: params[:page])
  end

   def attending
    @title = "Attending"
    @user = User.find(params[:id])
    @events = @user.attended_events.paginate(page: params[:page])
    render 'show_attend'
  end


private

def admin_user
	redirect_to(root_url) unless current_user.admin?
end

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation)
	end

	def correct_user
		@user = User.find(params[:id])
		redirect_to root_url unless current_user?(@user)
	end

end
