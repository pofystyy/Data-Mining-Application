require_relative 'exceptions'
require 'nokogiri'
require 'open-uri'
require 'pry'

module DataMining
  class Parser
    class Exceptions
      class BaseParserExceptions < DataMining::Exceptions::BaseException; end
      class UrlFailure < BaseParserExceptions; end
      class InvalidElementsCount < BaseParserExceptions; end
    end
    def parser(url)
      html_data = open(url).read
      @nokogiri_object = Nokogiri::HTML(html_data)
    rescue Errno::ENOENT
      raise Exceptions::UrlFailure
    end

    def data(*args)
      raise Exceptions::InvalidElementsCount if args.empty?

      data = @nokogiri_object.css(args[0].join)
      data.map { |i| i.text }
    end
  end
end
