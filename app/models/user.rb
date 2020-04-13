class User < ActiveRecord::Base 
    has_many :ownerships 
    has_many :interactions 
    has_many :plants, through: :interactions 
    has_many :plants, through: :ownerships
    has_many :forecasts, through: :interactions  

    # puts "What is your name?"
    # name=gets.strip 
    # puts "What is your location?"
    # location =gets.strip 
    # name = User.create(name: "#{name}",location: "#{location}")
end