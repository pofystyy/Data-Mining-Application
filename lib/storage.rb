require_relative 'exceptions'
require 'mongo'

module DataMining
  class MongoStorage
    class Exceptions
      class BaseMongoStorageExceptions < DataMining::Exceptions::BaseException; end
      class MongoConnectionFailure < BaseMongoStorageExceptions; end
    end
    def initialize
      settings_line = ENV["SETTINGS_LINE"]
      database =  ENV["DATABASE"]
      collection = ENV["COLLECTION"]

      @collection = collection.to_sym unless collection.nil?

    begin
      Mongo::Logger.logger.level = ::Logger::FATAL
      @client = Mongo::Client.new([ settings_line ], database: database )
    rescue  Mongo::Error::InvalidCollectionName,
            Mongo::Error::InvalidDatabaseName
      raise Exceptions::MongoConnectionFailure
    end
    end

    def insert(data)
      @client[@collection].insert_one(data)
    end
  end
end
