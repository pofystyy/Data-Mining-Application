require_relative 'parser'
require_relative 'storage'

module DataMining
  class DataMining
    def initialize
      @parser  = Parser.new
      @storage = MongoStorage.new
    end

    def parse(url, html_element)
      @parser.parser(url, html_element)
    end

    def to_db(*args)
      @data = @parser.data(args)

      record
    end

    def record
      @data.each { |data| @storage.insert({ 'name': data }) }
    end
  end
end
