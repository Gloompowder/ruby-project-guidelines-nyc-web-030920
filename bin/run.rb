require_relative '../config/environment'
require 'rest-client'
require 'json'


path = "plants"
puts "What is your search criteria?"
searching_criteria = gets.strip 
puts "What is the #{searching_criteria}"
seraching = gets.strip
parameter = "#{searching_criteria}=#{searching}"
url = "https://trefle.io/api/#{path}?token=Z1dsRU13S2pibDFhbFJrWm1nZTlNZz09#{parameter}"
json = JSOn.parse(url)
pp json