class Event < ActiveRecord::Base
	belongs_to :user
	default_scope -> { order('created_at DESC') } #replace with event_time
	#validates :user_id, presence: true
	validates :title, length: { in: 2..50 }
	validates :comment, length: { maximum: 140 }
end
