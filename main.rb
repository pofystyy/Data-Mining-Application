require 'mongo'
require 'nokogiri'
require 'open-uri'

html_data = open('https://ain.ua').read
nokogiri_object = Nokogiri::HTML(html_data)
elements = nokogiri_object.css('.interesting-now')

settings_line = ENV["SETTINGS_LINE"]
database =  ENV["DATABASE"]
@collection = ENV["COLLECTION"]

Mongo::Logger.logger.level = ::Logger::FATAL
@client = Mongo::Client.new([ settings_line ], database: database )

parsed = {}
count = 0
while count < elements.css('.item-title').count
  elements.each do |element|

    parsed['name'] = element.css('.item-title')[count].text
    parsed['views'] = element.css('.views')[count].text

    @client[@collection.to_sym].insert_one(parsed)

    count += 1
  end
end
