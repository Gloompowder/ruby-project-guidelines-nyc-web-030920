class AddDbIdToPlants < ActiveRecord::Migration[5.0]
  def change
    add_column :plants, :api_id, :integer
  end
end
