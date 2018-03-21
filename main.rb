require 'pg'
require 'nokogiri'

html_data = open('https://ain.ua').read
nokogiri_object = Nokogiri::HTML(html_data)
elements = nokogiri_object.css('.block-interesting').css('.block-interesting-list')

parsed = [] # array for parsed text
count = 0
while count < elements.css('.item-title').count
	elements.each do |element|
		parsed << count+1 # post id
		parsed << element.css('.item-title')[count].text # post name
		parsed << element.css('.views')[count].text # post views

		count += 1
	end
end

arr = []
arr << parsed.each_slice(3) { |f| arr << f } # sample of individual posts