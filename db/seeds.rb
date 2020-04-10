User.destroy_all 
Plant.destroy_all
Forecast.destroy_all 
Ownership.destroy_all 
Interaction.destroy_all
u1 = User.create(name: "Meg Griffin", location: "Quahog, Rhode Island")
u2 = User.create(name: "Edward Cullen", location: "Fork, Washington")
u3 = User.create(name: "Bella Swan", location: "Fork, Washington")
u4 = User.create(name: "Alicia Whitney", location: "Brooklyn, New York")
u5 = User.create(name: "William Lin", location: "New York, New York")
u6 = User.create(name: "Cardi B", location: "Bronx, New York")
u7 = User.create(name: "Nicki Minaj", location: "Queens, New York")
u8 = User.create(name: "Beyonce", location: "Houston, Texas")
u9 = User.create(name: "Instagrammer", location: "Los Angeles, California")
u10 = User.create(name: "Homer Simpson", location: "Springfield, Ohio")
u11 = User.create(name: "Neil Patrick Harris", location: "New York, New York")

# p1 = Plant.create(nickname: "Cactus Everdeen", common_name: "heather", scientific_name: "")
# t.string :nickname 
# t.string :common_name 
# t.string :scientific_name 
# t.integer :temperature_maximum 
# t.integer :temperature_minimum 
# t.string :percipitation_maximum 
# t.string :percipitiation_minimum 
# t.string :moisture_use 
# t.string :fruit_seed_period