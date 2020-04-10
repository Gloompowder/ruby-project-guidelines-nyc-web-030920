class Plant < ActiveRecord::Base 
    has_many :interactions 
    has_many :ownerships 
    has_many :users, through: :interactions 
    has_many :forecasts, through: :interactions 
    has_many :users, through: :ownerships 
end