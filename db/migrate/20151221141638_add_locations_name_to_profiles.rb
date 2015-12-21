class AddLocationsNameToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :locations_name, :string
  end
end
