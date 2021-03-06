class PagesController < ApplicationController
	
  def home
	  
	  if params[:tag].present? 
	      @profiles = Profile.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 30)
	    else
	      @profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	    end  
  	
	if params[:category].blank?
		@profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	else
		@category_id = Category.find_by(name: params[:category]).id
		@profile = Profile.where(category_id: @category_id).order("created_at DESC")
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
    @profiles = @filterrific.find.page(params[:page]).paginate(:page => params[:page], :per_page => 30)
	
    respond_to do |format|
      format.html
      format.js
    end
    
     def tag_cloud
        @profiles = Profile.tag_counts_on(:tags).limit(1).order('count desc')
    end
    
  end
  
  def tags
	  
	if params[:tag].present? 
	@filterrific = initialize_filterrific(
      Profile,
      params[:filterrific],
      :select_options => {
        sorted_by: Profile.options_for_sorted_by,
        with_location_id: Location.options_for_select
      },
	  :persistence_id => false,   
    ) or return
	  @profiles = Profile.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 30)
	else
	  @profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	end 

  end
  
  def about
	   
  end 
  
  
  def myprofiles
	@profiles = Profile.all.order("created_at DESC")
  end
end
