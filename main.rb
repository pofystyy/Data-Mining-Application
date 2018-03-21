require 'pg'
require 'nokogiri'

html_data = open('https://ain.ua').read
nokogiri_object = Nokogiri::HTML(html_data)