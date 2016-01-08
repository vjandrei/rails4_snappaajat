class Profiles::LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_profile

  def create
    @profile.likes.where(user_id: current_user.id).first_or_create

    respond_to do |format|
      format.html { redirect_to @profile }
      format.js
    end
  end

  def destroy
    @profile.likes.where(user_id: current_user.id).destroy_all

    respond_to do |format|
      format.html { redirect_to @profile }
      format.js
    end
  end

  private

    def set_profile
		@profile = Profile.friendly.find(params[:profile_id])
		#@profile = Profile.find(params[:profile_id])
    end
end