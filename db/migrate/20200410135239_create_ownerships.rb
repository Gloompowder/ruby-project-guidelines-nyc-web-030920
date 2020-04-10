class CreateOwnerships < ActiveRecord::Migration[5.0]
  def change
    create_table :ownerships do |t| 
      t.integer :plant_id 
      t.integer :user_id 
    end
  end
end
