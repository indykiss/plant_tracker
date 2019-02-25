class PlantId < ActiveRecord::Migration

  def change
    rename_column :decorations, :plants_id, :plant_id
    end
  end
end
