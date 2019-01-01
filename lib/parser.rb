require 'nokogiri'
require 'open-uri'

module DataMining
  class Parser
    def parser(url, html_element)
      html_data = open(url).read
      @nokogiri_object = Nokogiri::HTML(html_data)
    end

    def data(*args)
      data = @nokogiri_object.css(args[0].join)
      data.map { |i| i.text }
    end
  end
end
