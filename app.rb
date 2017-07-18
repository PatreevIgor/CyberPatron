require 'net/http'
require 'uri'
require 'json'
require 'dotenv'
Dotenv.load

classid = 374499946
instanceid = 253074789
language = 'ru'

url = "https://market.dota2.net/api/ItemInfo/#{classid}_#{instanceid}/#{language}/?key=#{ENV['SECRET_KEY']}"
uri = URI.parse(url)
response = Net::HTTP.get_response(uri)
my_hash = JSON.parse(response.body)
my_hash.each do |key,value|
  puts key.to_s + '==' + value.to_s
end
