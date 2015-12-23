class PagesController < ApplicationController
	
  def home
  	
	if params[:category].blank?
		@profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	else
		@category_id = Category.find_by(name: params[:category]).id
		@profile = Profile.where(category_id: @category_id).order("created_at DESC")
	end
	
	
  end
  
  def tags
	  
	if params[:tag].present? 
	  @profiles = Profile.tagged_with(params[:tag]).paginate(:page => params[:page], :per_page => 30)
	else
	  @profiles = Profile.all.order("created_at DESC").paginate(:page => params[:page], :per_page => 30)
	end  
	
  end
  
  def about
	   
  end 
end
