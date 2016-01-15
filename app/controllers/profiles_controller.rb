class ProfilesController < ApplicationController
  before_action :set_profile, only: [:show, :edit, :update, :destroy, :upvote]
  before_action :correct_user, only: [:edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_profile, only: [:show, :edit, :update, :destroy]

  # GET /profiles
  # GET /profiles.json

    def index
	    
	    prepare_meta_tags title: "Profiili", description: "Find on this page all our lovely products"
	    
		if params[:tag].present? 
	      @profiles = Profile.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 30)
	    else
	      @profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	    end  
	    
	    @filterrific = initialize_filterrific(
	      Profile,
	      params[:filterrific],
	      :select_options => {
	        sorted_by: Profile.options_for_sorted_by,
	        with_location_id: Location.options_for_select
	      },
		  :persistence_id => false,   
	    ) or return
	    @profiles = @filterrific.find.page(params[:page])
	
	    respond_to do |format|
	      format.html
	      format.js
	    end
	    
	end

  # GET /profiles/1
  # GET /profiles/1.json
  def show
   @profiles = Profile.friendly.find(params[:id])
   prepare_meta_tags(
   title: "Snappaaja " + @profiles.name,
   description: @profile.description,
   keywords: @profile.nickname + "Snapchat",
   image: "http://www.snappaajat.fi" + @profile.image.url(),
   twitter: {site: request.url,
        site: "@snappaajat",
        card: @profiles.name + @profile.description,
        description: @profile.description,
        image: "http://www.snappaajat.fi" + @profile.image.url()},
   og: {url: request.url,
        site: "Snappaajat.fi",
        title: "Snappaaja - " + @profiles.name,
        image: "http://www.snappaajat.fi" + @profile.image.url(),
        description: @profile.description,
        type: 'website'})
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
  
  def upvote
  	##@profile = Profile.find(params[:id])
  	##@profile.upvote_by current_user
  	##redirect_to :back
  	
  	@profile.upvote_from current_user
  	redirect_to :back
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
      @profile = Profile.friendly.find(params[:id])
    end
    
    def correct_user
	    @profile = current_user.profiles.friendly.find(params[:id])
		redirect_to profiles_path, notice: "Not authorized to edit this pin" if @profile.nil?
	end

    # Never trust parameters from the scary internet, only allow the white list through.
    def profile_params
      params.require(:profile).permit(:name, :nickname, :description, :image, :snapcode, {category_ids: []}, :tag_list, :facebook, :twitter, :instagram, :linkedin, :snapcode, :location_id, :slug)
    end
    
    def find_profile
	    @profile = Profile.friendly.find(params[:id])
	end
end
