class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants do |t| 
      t.string :nickname 
      t.string :common_name 
      t.string :scientific_name 
      t.float :temperature_minimum 
      t.float :percipitation_maximum 
      t.float :percipitiation_minimum 
      t.string :moisture_use 
      t.integer :serial
    end
  end
end
