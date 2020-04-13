require_relative '../config/environment'
require 'rest-client'
require 'json'

# USER SETS UP THEIR PROFILE 
name = TTY::Prompt.new
name.ask("What is your name?") do |q|
q.required true
q.validate /\A\w+\Z/
q.modify   :capitalize
end
puts "What is your location?"
location = gets.strip 
user = {}
user[name] = User.create(name: name, location: location)
# ====
# DONE 
# ====



# FIND PLANT
# puts "What is your plant's nickname?"
# nickname = gets.strip 
# puts "What is #{nickname}'s' common_name?"
# common_name = gets.strip 
# puts "What is #{nickname}'s scientific_name?"
# scientific_name = gets.strip 
# plant = Plant.find_by(scientific_name: "#{scientific_name}", nickname: "#{nickname}")
# puts plant 



# # CHANGE NICKNAME
# if plant 
#     puts "You already have a #{scientific_name} under the nickname of #{nickname}. Would you like to change it's nickname?"
#     answer = gets.string 
#     answer.downcase
#     if answer == "yes"
#         puts "What would you like its nickname to be?"
#         new_nickname = gets.strip 
#             plant.nickname = new_nickname
#             puts "Ok, the nickname has been changed to #{new_nickname}." 
#     else  
#         "Ok, the nickname will not be changed." 
#     end 
#     ownership[name] = Ownership.create(name_id: User.find_by(name: name).id, plant_id: Plant.find_by(nickname: nickname, scientific_name: scientific_name).id)
# end 




        


# CREATING NEW PLANT
# puts "What's your new plant's nickname?"
# nickname = gets.strip 
# puts "Please enter your new plant's scientific name. If you don't know what it is, please leave it blank."
# scientific_name = gets.strip 
#     if scientific_name 
#         id=JSON.parse(RestClient.get("https://trefle.io/api/plants//?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09&scientific_name=#{scientific_name}"))[0]["id"]
#     else 
#         puts "What is your plant's common name?"
#         common_name=gets.strip
#         id=JSON.parse(RestClient.get("https://trefle.io/api/plants//?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09&common_name=#{common_name}"))[0]["id"]
#     end 
#     plant = {} 
#     plant["#{nickname}] = Plant.create(nickname: nickname,
#     common_name: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09&common_name=#{common_name}"))["common_name"],
#     scientific_name: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"))["scientific_name"],
# temperature_minimum: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"))["main_species"]["growth"]["temperature_minimum"]["deg_f"]
#   percipication_minimum: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"))["main_species"]["growth"]["precipitation_minimum"]["cm"],
# percipication_maximum: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"))["main_species"]["growth"]["precipitation_maximum"]["cm"],
# moisture_use: JSON.parse(RestClient.get("https://trefle.io/api/plants/#{id}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"))["main_species"]["growth"]["moisture_use"],
# serial: id)

# CREATING OWNERSHIP
# puts "Would you like to create an ownership?"
# owner = {} 
# owner["#{name}"]["#{nickname}"]=Ownership.create(name_id: Name.find_by(name: name).id, plant_id: Plant.find_by(nickname: nickname).id))

# CREATING INTERACTION
# puts "Would you like to log an interaction?"
# answer = gets.strip 

# DELETING PLANT 

# DELETING USER


# UPDATING OWNERSHIP
# puts "Are you giving a plant away?"
# answer = gets.strip 
# if answer == 'yes' || answer == 'Yes'
#     puts "What is the nickname of the plant?"
#     nickname = gets.strip 
#     puts "What is the scientific name of the plant?"
#     sciname = gets.strip 
#     puts "What is your name?"
#     name = gets.strip 
#     puts "What is the name of the new owner?"
#     new_name = gets.strip 
#     Ownership.find_by(name_id: Name.find_by(name: name).id, plant_id: Plant.find_by(nickname: nickname, scientific_name: sciname).id).destroy 
#     user[new_name] = Ownership.find_by(name_id: Name.find_by(name: name).id, plant_id: Plant.find_by(nickname: nickname, scientific_name: sciname).id)
# else 
#     puts "Ok, no changes have been made"
# end

170921


