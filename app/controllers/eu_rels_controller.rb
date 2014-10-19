class EuRelsController < ApplicationController
  before_action :signed_in_user

  def create
    @event = Event.find(params[:eu_rel][:attended_id])
    current_user.attend!(@event)
    redirect_to @event
  end

  def destroy
    @event = EuRel.find(params[:id]).attended
    current_user.unattend!(@event)
    redirect_to @event
  end
end