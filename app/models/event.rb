class Event < ActiveRecord::Base
	belongs_to :user_id
	has_many :passive_eu_rels, class_name: "EuRel", foreign_key: "attended_id", dependent: :destroy
	has_many :attenders, through: :passive_eu_rels, source: :attender
	default_scope -> { order('created_at DESC') } #replace with event_time
	#validates :user_id, presence: true
	validates :title, length: { in: 2..50 }
	validates :comment, length: { maximum: 140 }
end
