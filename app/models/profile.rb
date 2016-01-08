class Profile < ActiveRecord::Base
	belongs_to :user
	belongs_to :location
	mount_uploader :image, ImageUploader
	mount_uploader :snapcode, SnapcodeUploader
	has_many :likes
	
	extend FriendlyId
	friendly_id :nickname, use: :slugged
	
	validates_length_of :description, maximum: 160
	
	acts_as_taggable
	
	validates :name, :presence => true
	validates :nickname, :presence => true
	validates :description, :presence => true
	
	def can_validate
	   true
	end
	
	filterrific :default_filter_params => { :sorted_by => 'created_at_desc' },
	  :available_filters => %w[
	    sorted_by
	    search_query
	    with_location_id
	    with_created_at_gte
	  ]
	
	# default for will_paginate
	self.per_page = 10
	
	belongs_to :location
	
	scope :search_query, lambda { |query|
    return nil  if query.blank?
    # condition query, parse into individual keywords
    terms = query.downcase.split(/\s+/)
    # replace "*" with "%" for wildcard searches,
    # append '%', remove duplicate '%'s
    terms = terms.map { |e|
      (e.gsub('*', '%') + '%').gsub(/%+/, '%')
    }
    # configure number of OR conditions for provision
    # of interpolation arguments. Adjust this if you
    # change the number of OR conditions.
    num_or_conditions = 3
    where(
      terms.map {
        or_clauses = [
          "LOWER(profiles.name) LIKE ?",
          "LOWER(profiles.nickname) LIKE ?",
          "LOWER(profiles.description) LIKE ?"
        ].join(' OR ')
        "(#{ or_clauses })"
      }.join(' AND '),
      *terms.map { |e| [e] * num_or_conditions }.flatten
    )
  }
  scope :sorted_by, lambda { |sort_option|
    # extract the sort direction from the param value.
    direction = (sort_option =~ /desc$/) ? 'desc' : 'asc'
    case sort_option.to_s
    when /^created_at_/
      order("profiles.created_at #{ direction }")
    when /^name_/
      order("LOWER(profiles.name) #{ direction }, LOWER(profiles.name) #{ direction }")
    when /^country_name_/
      order("LOWER(locations.name) #{ direction }").includes(:locations)
    else
      raise(ArgumentError, "Invalid sort option: #{ sort_option.inspect }")
    end
  }
  scope :with_location_id, lambda { |location_ids|
    where(:location_id => [*location_ids])
  }
  scope :with_created_at_gte, lambda { |ref_date|
    where('profiles.created_at >= ?', ref_date)
  }
  
  delegate :name, :to => :location, :prefix => true
  
  def self.options_for_sorted_by
    [
      ['Nimi (a-ö)', 'name_asc'],
      ['Rekisteröitynyt (uudet ensin)', 'created_at_desc'],
      ['Rekisteröitynyt (vanhat ensin)', 'created_at_asc']
    ]
  end
  
   def decorated_created_at
    created_at.to_date.to_s(:long)
  end

	def user_params
    	params.require(:profile).permit(:nickname, :description, {category_ids: []}, :tag_list, :image, :snapcode, :facebook, :twitter, :instagram, :linkedin, :snapcode, :location_id)
	end
end
