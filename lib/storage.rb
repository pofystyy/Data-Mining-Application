require 'mongo'

module DataMining
  class MongoStorage
    def initialize
      @settings_line = ENV["SETTINGS_LINE"]
      @database =  ENV["DATABASE"]
      @collection = ENV["COLLECTION"]

      Mongo::Logger.logger.level = ::Logger::FATAL
      @client = Mongo::Client.new([ @settings_line ], database: @database )
    end

    def insert(data)
      @client[@collection.to_sym].insert_one(data)
    end
  end
end
