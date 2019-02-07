class CreateLocations < ActiveRecord::Migration
  
  def change
    create_table :locations do |t|
      t.string :name
      t.integer :user_id
      t.string :city
      t.string :other
    end
  end
end
