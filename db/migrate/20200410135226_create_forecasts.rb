class CreateForecasts < ActiveRecord::Migration[5.0]
  def change
    create_table :forecasts do |t| 
      t.string :date 
      t.string :time 
      t.string :weather 
      t.string :temperature 
      t.string :humidity 
    end
  end
end
