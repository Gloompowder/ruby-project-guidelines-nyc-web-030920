class Interation < ActiveRecord::Base 
    belongs_to :plant
    belongs_to :user
    belongs_to :forecast
end 