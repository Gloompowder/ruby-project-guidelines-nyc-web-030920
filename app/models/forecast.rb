class Forecast < ActiveRecord::Base 
    has_many :interactions 
    has_many :plants, through: :interactions 
    has_many :users, through: :interactions 
end