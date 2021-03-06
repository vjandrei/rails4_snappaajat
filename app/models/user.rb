class User < ActiveRecord::Base
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
		     :recoverable, :rememberable, :trackable, :validatable
	has_many :profiles
	validates :terms_and_conditions, acceptance: true
   
	has_many :likes
	
	acts_as_voter
	
	def likes?(profile)
		profile.likes.where(user_id: id).any?
	end
	
	def liker_image
    	
	end
end
