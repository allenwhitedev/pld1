module EventsHelper

  def wrap(comment)
    sanitize(raw(comment.split.map{ |s| wrap_long_string(s) }.join(' ')))
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:success] = "Event Created"
      redirect_to events_url
    else
      @feed_items = []
      render 'pages/events'
    end
  end

  private

    def wrap_long_string(text, max_width = 30)
      zero_width_space = "&#8203;"
      regex = /.{1,#{max_width}}/
      (text.length < max_width) ? text :
                                  text.scan(regex).join(zero_width_space)
    end
end