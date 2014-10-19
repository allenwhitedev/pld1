class EventsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy
	# before_action :signed_in_mod, only: [:create, :destroy]


	#should add show method for event(or have destroy go somewhere else but probably want to show individual events)

	def destroy
		@event.destroy
		redirect_to events_url
	end

	def create
		@event = Event.new(event_params)
		if @event.save
			flash[:success] = "Event Created"
			redirect_to events_url
		else
			@feed_items = []
			flash[:danger] = "Event failed to be created"
			redirect_to events_url
		end
	end

	def index
  	@events = Event.paginate(page: params[:page])
  	@event = Event.new
  end

   def show
  	@event = Event.find(params[:id])
  end

  def attenders
    @title = "Attenders"
    @event = Event.find(params[:id])
    @users = @user.attenders.paginate(page: params[:page])
    render 'show_attend'
  end

private
	
	def event_params
		params.require(:event).permit(:title, :comment, :points, :event_time)
		# NEED TO CONTROL WHAT ATTRIBUTES CAN BE SET TO PREVENT MASS ASSIGNEMNT
	# WRITE A FUNCTIONING REQUIRE AND PERMIT LINE HERE LATER TO ONLY ALLOW CERTAIN ATTRIBUTES TO BE SET
	end

	def correct_user
		@event = current_user.events.find_by(id: params[:id])
		redirect_to event_url if @event.nil?
	end

end