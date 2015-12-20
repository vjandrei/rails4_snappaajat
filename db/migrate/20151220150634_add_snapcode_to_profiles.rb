class AddSnapcodeToProfiles < ActiveRecord::Migration
  def change
    add_column :profiles, :snapcode, :string
  end
end
