class CreateInteractions < ActiveRecord::Migration[5.0]
  def change
    create_table :interactions do |t| 
      t.string :action 
      t.integer :plant_id 
      t.integer :user_id 
      t.integer :forecast_id 
    end
  end
end
