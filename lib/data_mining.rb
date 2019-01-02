require_relative 'parser'
require_relative 'storage'

module DataMining
  class DataMining
    def initialize
      @parser  = Parser.new
      @storage = MongoStorage.new
    end

    def parse(url)
      @parser.parser(url)
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
