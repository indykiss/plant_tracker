class CreatePlants < ActiveRecord::Migration

  def change
    create_table :plants do |t|
      t.string :name
      t.string :water_needed
      t.string :light_needed
      t.belongs_to :user 
    end
  end
end
