class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json

    def index
	    if params[:tag].present? 
	      @profiles = Profile.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 12)
	    else
	      @profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 12)
	    end  
	    @profile = current_user.profiles.build
	end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
  end

  # GET /profiles/new
  def new
    @profile = current_user.profiles.build
  end

  # GET /profiles/1/edit
  def edit
  end

  # POST /profiles
  # POST /profiles.json
  def create
    @profile = current_user.profiles.build(profile_params)

    respond_to do |format|
      if @profile.save
        format.html { redirect_to root_path, notice: 'Profile was successfully created.' }
        format.json { render :show, status: :created, location: @profile }
      else
        format.html { render :new }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /profiles/1
  # PATCH/PUT /profiles/1.json
  def update
    respond_to do |format|
      if @profile.update(profile_params)
        format.html { redirect_to root_path, notice: 'Profile was successfully updated.' }
        format.json { render :show, status: :ok, location: @profile }
      else
        format.html { render :edit }
        format.json { render json: @profile.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # POST /landscapes/1/crop
  # POST /landscapes/1/crop.json
  def crop
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.json
  def destroy
    @profile.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Profile was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_profile
      @profile = Profile.find(params[:id])
    end
    
    def correct_user
	    @profile = current_user.profiles.find_by(id: params[:id])
		redirect_to profiles_path, notice: "Not authorized to edit this pin" if @profile.nil?
	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :nickname, :description, :image, :snapcode, {category_ids: []}, :tag_list, :image_crop_x, :image_crop_y, :image_crop_w, :image_crop_h, :facebook, :twitter, :instagram, :linkedin)
    end
    
    def find_profile
	    @profile = Profile.find(params[:id])
	end
end
