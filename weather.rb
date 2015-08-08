require 'yahoo_weatherman'
require 'artii'



#Welcome
a = Artii::Base.new
puts a.asciify('Weather')

  
#get zipcode from user
puts "What is your zipcode?"
zipcode = gets.chomp

#lookup weather from yahoo
client = Weatherman::Client.new :unit => 'F'
response = client.lookup_by_location(zipcode)

#assign weather to variables
temp = response.condition['temp'].to_i
currentCondition = response.condition['text'].downcase
currentCity = response.location['city']
sunrise = response.astronomy['sunrise']
sunset = response.astronomy['sunset']
today = Time.now.strftime('%w').to_i

#gives the user the current weather
puts "-"*55
puts "Currently it is #{temp}˚ and #{currentCondition} in #{currentCity}. Sunrise is #{sunrise} and sunset is #{sunset}."
puts "-"*55

#Asks if the user wants the forecast and gets it if y
puts "Would you like the forecast for #{currentCity}? (Y/N)"
answer = gets.chomp.downcase

if answer == 'y'

response.forecasts.each do |forecast|
	day = forecast['date']
	weekday = day.strftime('%w').to_i
	
	if weekday == today
		dayName = "Today"
	elsif weekday == today + 1
		dayName = "Tomorrow"
	else
		dayName = day.strftime('%A')
	end
	
	puts dayName + " is going to be " + forecast['text'].to_s.downcase + " with a low of " + forecast['low'].to_s + "˚ and a high of " + forecast['high'].to_s + "˚."
	puts "-"*55
end
else answer == 'n'
	puts a.asciify('Goodbye')
end
