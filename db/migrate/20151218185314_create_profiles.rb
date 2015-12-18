class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.string :name
      t.string :nickname
      t.string :description
      t.string :facebook
      t.string :twitter
      t.string :instagram
      t.string :linkedin

      t.timestamps null: false
    end
  end
end
