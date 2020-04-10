class User < ActiveRecord::Base 
    has_many :ownerships 
    has_many :interactions 
    has_many :plants, through: :interactions 
    has_many :plants, through: :ownerships
    has_many :forecasts, through: :interactions  

end