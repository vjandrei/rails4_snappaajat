class Profile < ActiveRecord::Base
	belongs_to :user
	mount_uploader :image, ImageUploader
	mount_uploader :snapcode, SnapcodeUploader
	
	validates_length_of :description, maximum: 160
	
	acts_as_taggable
	
	def user_params
    params.require(:profile).permit(:nickname, :description, {category_ids: []}, :tag_list, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :image, :snapcode, :facebook, :twitter, :instagram, :linkedin, :snapcode)
	end
end
