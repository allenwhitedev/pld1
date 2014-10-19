class EuRel < ActiveRecord::Base
	belongs_to :attender, class_name: "User"
	belongs_to :attended, class_name: "Event"
	validates :attender_id, presence: true
	validates :attended_id, presence: true
end
