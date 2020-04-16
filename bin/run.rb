require_relative '../config/environment'
require 'rest-client'
require 'json'
prompt = TTY::Prompt.new

api_beginning = "https://trefle.io/api/plants/"
my_key = "/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"

puts "What's your name?"
name = gets.strip 
puts "\n\n\n\n\n\n"
print TTY::Box.frame "Hello #{name}!"
user = User.find_by(name: name)
if !user 
    confirm = prompt.select("Please save youself as a new user by selecting Users in the Main Menu and the New Profile tab.", ["Ok"])
end

# puts box
puts "Welcome to Logger! We help log interactions between users and their plants."
main_menu = ["Plants", "Users", "Interactions", "Forecast", "Log Out"]
    main_choice = nil 
        while main_choice != "Log Out"
            main_choice = prompt.select("This is the main menu.", main_menu)
            if main_choice == "Plants"
                plant_menu = ["New Plant", "Change Owner", "Delete Plant", "My Plants",  "Exit"]
                plant_choice = nil 
                while plant_choice != "Exit"
                    plant_choice = prompt.select("What's next?", plant_menu)
                    if plant_choice == "New Plant"
                        puts "What's your new plant's nickname?"
                        nickname = gets.strip 
                        puts "Please enter your new plant's scientific name. If you don't know what it is, please leave it blank.\n"
                        scientific_name = gets.strip 
                        if scientific_name == "" || scientific_name == " "
                            puts "What is your plant's common name?\n"
                            common_name=gets.strip
                            id=JSON.parse(RestClient.get("#{api_beginning}#{my_key}&common_name=#{common_name}")).first["id"]
                        else 
                            id=JSON.parse(RestClient.get("#{api_beginning}#{my_key}&scientific_name=#{scientific_name}")).first["id"]
                        end 
                        plant_info = JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))
                        plant = {} 
                        plant["#{nickname}"] = Plant.create(nickname: nickname,
                        common_name: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}&common_name=#{common_name}"))["common_name"],
                        scientific_name: plant_info["scientific_name"],
                        temperature_minimum: plant_info["main_species"]["growth"]["temperature_minimum"]["deg_f"],
                        percipitation_minimum: plant_info["main_species"]["growth"]["precipitation_minimum"]["cm"],
                        percipitation_maximum: plant_info["main_species"]["growth"]["precipitation_maximum"]["cm"],
                        moisture_use: plant_info["main_species"]["growth"]["moisture_use"],
                        serial: id)
                            Ownership.create(user_id: User.find_by(name: name).id, plant_id: Plant.find_by(nickname: nickname, scientific_name: plant["#{nickname}"].scientific_name).id)
                            puts "You have added the plant into your collection.\n"
                    # end
                    elsif plant_choice == "My Plants"
                        my_plant_set =  user.plants.map do |t| t. nickname end << "Exit"
                        my_plant_data = nil 
                        while my_plant_data != "Exit"
                            my_plant_data = prompt.select("What would you like to look up?", my_plant_set)
                            if my_plant_data != "Exit"
                                detailed_info = ["Common Name", "Scientific Name", "Temperature Minimum", "Precipitation Maximum", "Precipitation Minimum", "Moisture Use", "Serial", "Exit"]
                                detailed_info_choice = nil 
                                while  detailed_info_choice != "Exit"
                                    detailed_info_choice = prompt.select("Here are your choices.\n", detailed_info)
                                    if detailed_info_choice !="Exit"
                                    chosen_plant = Plant.find_by(nickname: "#{my_plant_data}")
                                        if detailed_info_choice == "Common Name"
                                            puts chosen_plant.common_name
                                        elsif detailed_info_choice == "Scientific Name"
                                            puts chosen_plant.scientific_name
                                        elsif detailed_info_choice == "Temperature Minimum"
                                            puts chosen_plant.temperature_minimum
                                        elsif detailed_info_choice == "Precipitation Maximum"
                                            puts chosen_plant.percipitation_maximum
                                        elsif detailed_info_choice == "Precipitation Minimum"
                                            puts chosen_plant.percipitation_minimum
                                        elsif detailed_info_choice == "Moisture Use"
                                            puts chosen_plant.moisture_use
                                        elsif detailed_info_choice == "Serial"
                                            puts chosen_plant.serial
                                        end
                                    end
                                end
                            end
                        end
                    elsif plant_choice == "Change Owner"
                        puts "What's of the name of the new owner?"
                        new_owner = gets.strip 
                        user_plant = user.plants.map do |t| t.nickname end << "Exit"
                        user_plant_choice = nil 
                        while user_plant_choice != "Exit" 
                            user_plant_choice = prompt.select("Which plant are you giving away?", user_plant)
                            if user_plant_choice && user_plant_choice!= "Exit"
                                puts "Ok, #{user_plant_choice} is now #{new_owner}'s #{user.plants.map do |t| t.scientific_name end.last}."
                                Ownership.create(user: User.find_by(name: "#{new_owner}"), plant: Plant.find_by(nickname: "#{user_plant_choice}"))
                                Ownership.find_by(user: User.find_by(name: "#{name}"), plant_id: Plant.find_by(nickname: "#{user_plant_choice}")).delete
                                user_plant = user.plants.map do |t| t.nickname end << "Exit"
                            end
                        end
                    elsif plant_choice == "Delete Plant" 
                        user_plant = User.all.find_by(name: "#{name}").plants.map do |t| t.nickname end << "Exit"
                        user_plant_choice = nil 
                        while user_plant_choice != "Exit" 
                            user_plant_choice = prompt.select("Which plant are you deleting?", user_plant)
                            if user_plant_choice != "Exit"
                                puts "Ok, #{user_plant_choice} the #{Plant.find_by(nickname: "#{user_plant_choice}")}is now deleted."
                                Ownership.find_by(plant: Plant.find_by(nickname: "#{user_plant_choice}")).destroy
                                Plant.find_by(nickname: "#{user_plant_choice}").destroy
                                user_plant = User.all.find_by(name: "#{name}").plants.map do |t| t.nickname end << "Exit"
                            end
                        end
                    end
                end
            elsif main_choice == "Users"
                user_menu = ["New Profile", "My Plants", "Change Location", "Delete Profile",  "Exit"]
                user_choice = nil 
                while user_choice != "Exit"
                    user_choice = prompt.select("What's next?", user_menu)
                    if user_choice == "New Profile"
                        puts "What is your location?\n"
                        location_answer = gets.strip
                        user = {} 
                        if !User.find_by(name: name, location: location_answer)
                            user[name] = User.create(name: name, location: location_answer)
                            puts "Your profile has been saved."
                        else
                            puts "There is already a user with the name: #{name} and location: #{location_answer}."
                        end 
                    elsif user_choice == "My Plants" 
                        my_plant_list = User.find_by(name: "#{name}").plants.map do |t| t. nickname end 
                        my_plant_set = my_plant_list << "Exit"
                            my_plant_data = nil 
                            while my_plant_data != "Exit"
                                my_plant_data = prompt.select("What would you like to look up?", my_plant_set)
                                if my_plant_data != "Exit"
                                    detailed_info = ["Common Name", "Scientific Name", "Temperature Minimum", "Precipitation Maximum", "Precipitation Minimum", "Moisture Use", "Serial", "Exit"]
                                    detailed_info_choice = nil 
                                    while detailed_info_choice != "Exit"
                                        detailed_info_choice = prompt.select("Here are your choices.\n", detailed_info)
                                        chosen_plant = Plant.find_by(nickname: "#{my_plant_data}")
                                        if detailed_info_choice == "Common Name"
                                            puts chosen_plant.common_name
                                        elsif detailed_info_choice == "Scientific Name"
                                            puts chosen_plant.scientific_name
                                        elsif detailed_info_choice == "Temperature Minimum"
                                            puts chosen_plant.temperature_minimum
                                        elsif detailed_info_choice == "Precipitation Maximum"
                                            puts chosen_plant.percipitation_maximum
                                        elsif detailed_info_choice == "Precipitation Minimum"
                                            puts chosen_plant.percipitation_minimum
                                        elsif detailed_info_choice == "Moisture Use"
                                            puts chosen_plant.moisture_use
                                        elsif detailed_info_choice == "Serial"
                                            puts chosen_plant.serial
                                        end
                                    end
                                end
                            end
                    elsif user_choice == "Change Location" 
                        location_menu = ["#{User.find_by(name: "#{name}").location}"] << "Exit"
                        location_choice = nil 
                        while location_choice != "Exit"
                            location_choice = prompt.select("Select the location.",location_menu)
                            if location_menu
                                puts "What's your new location?"
                                new_location = gets.strip 
                                user.location = new_location
                                puts "Alright. your new location is saved as #{new_location}"
                            end
                        end
                    elsif user_choice == "Delete Profile" 
                        delete_user = ["#{user}"] << "Exit"
                        puts "This will remove all data associated with user. Please type 'delete' to confirm account deletion."
                        confirmation = gets.strip 
                        if confirmation == "delete"
                            user.ownerships.delete_all
                            user.plants.delete_all 
                            user.interactions.delete_all
                            user.delete
                            puts "Ok, the profile has been deleted. Go back to New Profile if you would like to remake."
                        else 
                            puts "Try again later."
                        end
                    end 
                end
            elsif main_choice == "Forecast"
                forecast_menu = ["Mini Forecast", "Saved Forecast", "Exit"]
                forecast_choice = nil 
                while forecast_choice != "Exit"
                    forecast_choice = prompt.select("What's next?", forecast_menu)
                    if forecast_choice == "Mini Forecast"
                        mini_forecast_menu = ["#{Date.yesterday}", "#{Date.today}", "#{Date.tomorrow}"] << "Exit"
                        mini_forecast_choice = nil 
                        while mini_forecast_choice!= "Exit"
                            mini_forecast_choice = prompt.select("Which date do you want to add a Forecast for?", mini_forecast_menu)
                            if mini_forecast_choice == "#{Date.yesterday}"
                                puts "What weather is it?"
                                date_weather = gets.strip
                                puts "What is the temperature?"
                                date_temperature = gets.strip 
                                puts "What is the humidity?"
                                date_humidity = gets.strip 
                                puts "Ok, a new forecast has been saved."
                                forecast1 = Forecast.create(date: "#{Date.today}", time: nil, weather: "#{date_weather}", temperature: "#{date_temperature}", humidity: "#{date_humidity}")
                            elsif mini_forecast_choice == "#{Date.today}"
                                puts "What weather is it?"
                                date_weather = gets.strip
                                puts "What is the temperature?"
                                date_temperature= gets.strip 
                                puts "What is the humidity?"
                                date_humidity = gets.strip 
                                puts "Ok, a new forecast has been saved."
                                forecast1 = Forecast.create(date: "#{Date.today}", time: nil, weather: "#{date_weather}", temperature: "#{date_temperature}", humidity: "#{date_humidity}")
                            elsif mini_forecast_choice == "#{Date.tomorrow}"
                                puts "What weather is it?"
                                date_weather = gets.strip
                                puts "What is the temperature?"
                                date_temperature = gets.strip 
                                puts "What is the humidity?"
                                date_humidity = gets.strip 
                                puts "Ok, a new forecast has been saved."
                                forecast1 = Forecast.create(date: "#{Date.today}", time: nil, weather: "#{date_weather}", temperature: "#{date_temperature}", humidity: "#{date_humidity}")
                            end
                        end
                    elsif forecast_choice == "Saved Forecast" 
                    forecast_saved = Forecast.all.map do |d| d.date end.uniq << "Exit"
                    forecast_saved_choice = nil 
                        while forecast_saved_choice != "Exit"
                            forecast_saved_choice = prompt.select("Which date do you want the forecast of?", forecast_saved)
                            if forecast_saved_choice
                            weather_menu = ["Weather", "Temperature", "Humidity", "Exit"]
                            weather_menu_choice = nil 
                                while weather_menu_choice!= "Exit"
                                    weather_menu_choice = prompt.select("Select the following", weather_menu)
                                    if weather_menu_choice == "Weather"
                                        puts "#{Forecast.find_by(date: "#{forecast_saved_choice}").weather}"
                                    elsif weather_menu_choice == "Temeprature"
                                        puts "#{Forecast.find_by(date: "#{forecast_saved_choice}").temperature}"
                                    elsif weather_menu_choice == "Humidity"
                                        puts "#{Forecast.find_by(date: "#{forecast_saved_choice}").humidity}"
                                    end
                                end
                            end
                        end
                    end
                end 
            elsif main_choice == "Interactions"
                inter_menu = ["New Interaction", "Exit"]
                inter_choice = nil 
                while inter_choice!= "Exit"
                    inter_choice = prompt.select("What's next?", inter_menu)
                    if inter_choice == "New Interaction"
                        new_inter_menu = User.all.find_by(name: "#{name}").plants.map do |t| t.nickname end << "Exit"
                        new_inter_choice = nil 
                        while new_inter_choice != "Exit"
                            new_inter_choice = prompt.select("Which plant do you want to interact with?", new_inter_menu)
                            specific_inter_menu = ["Water", "Prune", "Take in", "Take out", "Fertilize", "Look at", "Sing to", "Repot", "Exit"]
                            specific_inter_choice = nil 
                            while  specific_inter_choice != "Exit"
                                specific_inter_choice = prompt.select("How would you like to interact?", specific_inter_menu)
                                if specific_inter_choice == "Water"
                                    puts "Ok, you have just watered #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Prune"
                                    puts "Ok, you have just pruned #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Take in"
                                    puts "Ok, you have just brought in #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Take out"
                                    puts "Ok, you have just taken out #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Fertilize"
                                    puts "Ok, you have just fertilize #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Look at"
                                    puts "Ok, you have just looked at #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Sing to"
                                    puts "Ok, you have just sung to #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                elsif specific_inter_choice == "Repot"
                                    puts "Ok, you have just repotted #{new_inter_choice} on date:#{Date.today}"
                                    inter1 = Interaction.create(user: User.find_by(name: "#{name}"), plant: Plant.find_by(nickname: "#{new_inter_choice}"), forecast_id: Forecast.find_by(date: "#{Date.today}"))
                                end
                            end
                        end
                    end
                end
            end
        end

# USER SETS UP THEIR PROFILE 
# name = TTY::Prompt.new
# name_answer = name.ask("What is your name?") do |q|
# q.required true
# q.validate /\A\w+\Z/
# q.modify   :capitalize
# end 
# location = TTY::Prompt.new
# location_answer = location.ask("What is your location?") do |q|
#     q.required true
# end
# user = {} 
# if User.find_by(name: name_answer, location: location_answer)
#     puts "There is already a user with the name #{name_answer} and location #{location_answer}."
# user[name] = User.create(name: name_answer, location: location_answer)
# puts "You are now saved as #{name_answer} from #{location_answer}."


    #     if home == "Plants"
    #         plantsmenu = ["New Plant", "Delete Plant", "My Plants", "Exit"]
    # plantscreen= nil
    # while plantscreen != "Exit"
    #   plantscreen = prompt.select("What would you like to do?", plantmenu)
    #     elsif home == "Users"   
    #         usermenu = ["New Profile", "Delete Profile", "Give Plant", "Exit"]
    # userscreen= nil
    # while userscreen != "Exit"
    #   userscreen = prompt.select("What would you like to do?", usermenu)
    #     elsif home == "Interactions" 
    #         interactionmenu = ["New Profile", "Delete Profile", "Give Plant", "Exit"]
    # interaction_screen= nil
    # while interaction_screen != "Exit"
    #   interaction_screen = prompt.select("What would you like to do?", interactionmenu)
    #     else end
    
# ====
# DONE 
# ====



# FIND PLANT
# nickname = TTY::Prompt.new
# nickname.ask("What is your plant's nickname?") do |q|
#     q.required true
#     # q.validate /\A\w+\Z/
#     q.modify   :capitalize
#     end
# sci_know = TTY::Prompt.new
#     sci_know.select("Do you know your #{nickname}'s scientific name?") do |q|
#     q.choice "Yes"
#     q.choice "No"
# end

# sci_name = TTY::Prompt.new
# sci_name.ask("What is your plant's scientific name?") do |q|
#     q.required true
#     # q.validate /\A\w+\Z/
#     q.modify   :capitalize 
# end
# else 
#     common_name.ask("What is your plant's common_name?") do |q| 
#         q.required true 
#         q.modify :capitalize 
#     end 
# end 

# plant = Plant.find_by(scientific_name: "#{scientific_name}", nickname: "#{nickname}")
# puts plant 

# puts "What is #{nickname}'s scientific_name?"
# scientific_name = gets.strip 




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
# api_beginning = "https://trefle.io/api/plants/"
# my_key = "/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09"
#     if scientific_name 
#         id=JSON.parse(RestClient.get("#{api_beginning}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09&scientific_name=#{scientific_name}"))[0]["id"]
#     else 
#         puts "What is your plant's common name?"
#         common_name=gets.strip
#         id=JSON.parse(RestClient.get("#{api_beginning}/?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09&common_name=#{common_name}"))[0]["id"]
#     end 
#     plant = {} 
#     plant["#{nickname}] = Plant.create(nickname: nickname,
#     common_name: JSON.parse(RestClient.get("#{#{api_beginning}#{id}#{my_key}&common_name=#{common_name}"))["common_name"],
#     scientific_name: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))["scientific_name"],
# temperature_minimum: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))["main_species"]["growth"]["temperature_minimum"]["deg_f"]
#   percipication_minimum: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))["main_species"]["growth"]["precipitation_minimum"]["cm"],
# percipication_maximum: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))["main_species"]["growth"]["precipitation_maximum"]["cm"],
# moisture_use: JSON.parse(RestClient.get("#{api_beginning}#{id}#{my_key}"))["main_species"]["growth"]["moisture_use"],
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




