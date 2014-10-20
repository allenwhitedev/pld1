class User < ActiveRecord::Base
	has_many :events, dependent: :destroy
	has_many :eu_rels, class_name: "EuRel", foreign_key: "attender_id", dependent: :destroy
	has_many :attended_events, through: :eu_rels, source: :attended 
	before_save { self.email = email.downcase }
	validates :name, length: { in: 2..50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, uniqueness: true, length: { in: 2..50 }, format: { with: VALID_EMAIL_REGEX }
	validates :password, length: { minimum: 6 }
	has_secure_password

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	def feed
		#Will add so that only feed of organization(s) user belongs to is shown
		Event.where("user_id = ?", id)
	end

	 # Attends an event
  def attend!(fun_event)
    eu_rels.create!(attended_id: fun_event.id)
    @pluspoints = self.total_points+=fun_event.points
    self.update_attribute(:total_points, @pluspoints)
  end

  # Unattend an event
  def unattend!(fun_event)
    eu_rels.find_by(attended_id: fun_event.id).destroy
  end

  # True if user is attending the event
  def attending?(fun_event)
    eu_rels.find_by(attended_id: fun_event)
  end

private
	
	def create_remember_token
		self.remember_token = User.digest(User.new_remember_token)
	end

end

