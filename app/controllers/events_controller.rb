class EventsController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :signed_in_mod, only: [:create, :destroy]

	def destroy
		@event.destroy
		redirect_to event_url
	end

	def create
		@event = current_user.events.build(event_params)
		if @event.save
			flash[:success] = "Event Created"
			redirect_to event_url
		else
			@feed_items = []
			render 'pages/events'
		end
	end

private
	
	def event_params
		params.require(:event).permit(:comment)
	end

	def correct_user
		@event = current_user.events.find_by(id: params[:id])
		redirect_to event_url if @event.nil?
	end