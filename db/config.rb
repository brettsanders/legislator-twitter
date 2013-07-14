require 'active_record'
require 'twitter'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => "#{File.dirname(__FILE__)}/../db/ar-sunlight-legislators.sqlite3")

Twitter.configure do |config|
  config.consumer_key = '29bkYEd2cmiH2ogHiEPOlA'
  config.consumer_secret = 'pPB0Y6e8rlnIuQmnPBEtMiv5iEnQTYsLR6HRwoTAqc'
  config.oauth_token = '190556671-YRvfzrnyryjUtA91PswS8v1eKVgL1WlenqZgw8aJ'
  config.oauth_token_secret = '2xGzxoHQfyF5HsP6Uplr85qjq3nteceF2oj5x4yTFw8'
end
