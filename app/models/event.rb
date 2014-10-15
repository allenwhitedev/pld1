class Event < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') } #replace with event_time
	validates :user_id, presence: true
	validates :comment, length: { maximum: 140 }
end
