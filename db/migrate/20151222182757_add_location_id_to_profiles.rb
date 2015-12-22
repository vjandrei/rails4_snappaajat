class AddLocationIdToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :location_id, :integer
    add_column :profiles, :location_name, :string
  end
end
