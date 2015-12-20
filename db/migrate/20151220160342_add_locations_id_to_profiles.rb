class AddLocationsIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :locations_id, :integer
  end
end
