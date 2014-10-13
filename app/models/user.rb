class User < ActiveRecord::Base
	has_many :events, dependent: :destroy
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

private
	
	def create_remember_token
		self.remember_token = User.digest(User.new_remember_token)
	end

end

