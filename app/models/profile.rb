class Profile < ActiveRecord::Base
	belongs_to :user
	mount_uploader :image, ImageUploader
	
	def user_params
    params.require(:profile).permit(:nickname, :description, {category_ids: []}, :tag_list, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :image, :snapcode, :facebook, :twitter, :instagram, :linkedin)
	end
end
