class DeleteType < ActiveRecord::Migration
  def change
    remove_column :plants, :type, :string
  end
end
