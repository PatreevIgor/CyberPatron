require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load

# classid = 374499946
# instanceid = 253074789
# language = 'ru'

# Инфа о шмотке
# url = "https://market.dota2.net/api/ItemInfo/#{classid}_#{instanceid}/#{language}/?key=#{ENV['SECRET_KEY']}"

# Инфа о состоянии продажи
# my_hash["status"]["site_online"] Переменная для условия
# url = "https://market.dota2.net/api/Test/?key=#{ENV['SECRET_KEY']}"


# Поставить на продажу все предметы
# url = "https://market.dota2.net/api/PingPong/?key=#{ENV['SECRET_KEY']}"

# Снять с продажи все предметы
#  url = "https://market.dota2.net/api/GoOffline/?key=#{ENV['SECRET_KEY']}"

# uri = URI.parse(url)
# response = Net::HTTP.get_response(uri)
# my_hash = JSON.parse(response.body)
# my_hash.each do |key,value|
#   puts key.to_s + '==' + value.to_s
# end
# puts my_hash["status"]["site_online"].class




def check_status
	url = "https://market.dota2.net/api/Test/?key=#{ENV['SECRET_KEY']}"
	uri = URI.parse(url)
	response = Net::HTTP.get_response(uri)
	my_hash = JSON.parse(response.body)
	my_hash["status"]["site_online"]
end

def trade_on
	url = "https://market.dota2.net/api/PingPong/?key=#{ENV['SECRET_KEY']}"
	uri = URI.parse(url)
	response = Net::HTTP.get_response(uri)
	my_hash = JSON.parse(response.body)
end

def trade_off
	url = "https://market.dota2.net/api/GoOffline/?key=#{ENV['SECRET_KEY']}"
	uri = URI.parse(url)
	response = Net::HTTP.get_response(uri)
	my_hash = JSON.parse(response.body)
end

loop do
	# puts "Соединение будет через 10 сек"
  sleep(10)
  
	check_status 
	if check_status == false and Time.now.utc.hour <= 21 and Time.now.utc.hour >= 4
		# puts "Использование trade_on"
		trade_on
	elsif check_status == true and Time.now.utc.hour > 21 and Time.now.utc.hour < 4
		# puts "Использование trade_off"
		trade_off
	else
		# puts "Торговля продолжается"
	end

end
