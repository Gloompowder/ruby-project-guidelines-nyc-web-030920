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

p1 = Plant.create(nickname: "Princess Morebucks", common_name: "Money Tree", scientific_name: "dolores mores", temperature_minimum: 30, percipitation_maximum: "1l", percipitation_minimum: "100ml", moisture_use: "30%", serial: 13412)
p2 = Plant.create(nickname: "Cactus Everdeen", common_name: "Cactus", scientific_name: "Spinia Touchia", temperature_minimum: 60, percipitation_maximum: "1.5l", percipitation_minimum: "50ml", moisture_use: "4%", serial: 13447)

o1 = Ownership.create(user_id: User.first.id, plant_id: Plant.first.id)
o2 = Ownership.create(user_id: User.first.id, plant_id: Plant.second.id)

f1 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f2 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f3 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f4 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f5 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f6 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f7 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f8 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f9 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f10 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f11 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f12 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f13 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f14 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f15 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f16 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f17 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f18 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f19 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f20 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f21 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f22 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f23 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f24 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f25 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f26 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f27 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f28 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f29 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f30 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f31 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f32 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f33 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")
f34 = Forecast.create(date: "February 12th, 2020", time: "23:00", weather: "Snowing", temperature: "4°", humidity: "11%")
f35 = Forecast.create(date: "February 2nd, 2020", time: "13:00", weather: "Snowing", temperature: "14°", humidity: "nil")


i1 = Interaction.create(action: "put inside", user_id: User.first.id, plant_id: Plant.first.id, forecast_id: Forecast.first.id)


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
# FORECAST
# t.string :date 
# t.string :time 
# t.string :weather 
# t.string :temperature 
# t.string :humidity 