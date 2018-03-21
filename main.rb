require 'pg'
require 'nokogiri'

html_data = open('https://ain.ua').read
nokogiri_object = Nokogiri::HTML(html_data)
elements = nokogiri_object.css('.block-interesting').css('.block-interesting-list')

# connection to the database
con = PG.connect 
	:dbname 	=> '***', 
	:user 		=> '***', 
  :password => '***'

# create a database table
con.exec "DROP TABLE IF EXISTS Posts"
  con.exec "CREATE TABLE Posts(Id INTEGER PRIMARY KEY, 
    Name VARCHAR(20), Views INT)"

parsed = [] # array for parsed text
count = 0
while count < elements.css('.item-title').count
	elements.each do |element|
		parsed << count + 1 # post id
		parsed << element.css('.item-title')[count].text # post name
		parsed << element.css('.views')[count].text # post views

		# add to database
		con.exec "INSERT INTO Posts VALUES(parsed[0], parsed[1], parsed[2])"

		count += 1
	end
end

