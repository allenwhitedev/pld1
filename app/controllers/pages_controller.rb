class PagesController < ApplicationController
  def home
  end

  def help
  end

  def calendar
  end

  def fb_login
  end

  def fb_test1
  end

  def pipeline
  end

  def events
    if signed_in?
    @event = current_user.events.build #maybe signed_in_mod as well or instead
    @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
end



