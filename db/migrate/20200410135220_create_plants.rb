class CreatePlants < ActiveRecord::Migration[5.0]
  def change
    create_table :plants do |t| 
      t.string :nickname 
      t.string :common_name 
      t.string :scientific_name 
      t.integer :temperature_maximum 
      t.integer :temperature_minimum 
      t.string :percipitation_maximum 
      t.string :percipitiation_minimum 
      t.string :moisture_use 
      t.string :fruit_seed_period
    end
  end
end
