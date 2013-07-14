require 'rake'
require 'rspec/core/rake_task'


require_relative 'db/config'
require_relative 'lib/sunlight_legislators_importer'
require_relative 'app/models/legislator'
require_relative 'app/models/representative'
require_relative 'app/models/senator'
require_relative 'app/models/tweet'

desc "create the database"
task "db:create" do
  touch 'db/ar-sunlight-legislators.sqlite3'
end

desc "drop the database"
task "db:drop" do
  rm_f 'db/ar-sunlight-legislators.sqlite3'
end

desc "migrate the database (options: VERSION=x, VERBOSE=false, SCOPE=blog)."
task "db:migrate" do
  ActiveRecord::Migrator.migrations_paths << File.dirname(__FILE__) + 'db/migrate'
  ActiveRecord::Migration.verbose = ENV["VERBOSE"] ? ENV["VERBOSE"] == "true" : true
  ActiveRecord::Migrator.migrate(ActiveRecord::Migrator.migrations_paths, ENV["VERSION"] ? ENV["VERSION"].to_i : nil) do |migration|
    ENV["SCOPE"].blank? || (ENV["SCOPE"] == migration.scope)
  end
end

desc 'Retrieves the current schema version number'
task "db:version" do
  puts "Current version: #{ActiveRecord::Migrator.current_version}"
end

desc "Run the specs"
RSpec::Core::RakeTask.new(:specs)

desc "populate db from csv"
task "db:populate" do 
  SunlightLegislatorsImporter.import('./db/data/legislators.csv')
end


def twitter_user_exists?(user)
  Twitter.user(user)
    true
  rescue Twitter::Error::NotFound
    false
end

desc "add 10 tweets for all congress people"
task "db:populate-tweets" do 
  
  reps_with_twitter = Representative.all_with_twitter
  sens_with_twitter = Senator.all_with_twitter

  reps_with_twitter.each do |rep|
    if twitter_user_exists?(rep.twitter_id)
      ten_full_tweets = Twitter.user_timeline("#{rep.twitter_id}", count:10)

      ten_tweet_texts = []

      ten_full_tweets.each do |full_tweet|
        ten_tweet_texts << full_tweet[:text]
      end

      ten_tweet_texts.each do |tweet_text|
        Tweet.create(legislator_id:rep.id, text:tweet_text)
      end
    end
  end

  sens_with_twitter.each do |sen|
    if twitter_user_exists?(sen.twitter_id)
      ten_full_tweets = Twitter.user_timeline("#{sen.twitter_id}", count:10)

      ten_tweet_texts = []

      ten_full_tweets.each do |full_tweet|
        ten_tweet_texts << full_tweet[:text]
      end

      ten_tweet_texts.each do |tweet_text|
        Tweet.create(legislator_id:sen.id, text:tweet_text)
      end
    end
  end
end

desc "tenderlove tweets"
task "db:tenderlove" do 
  sweet = Twitter.user_timeline("tenderlove", count:100)
  sweet.each { |tweet| puts tweet[:text] }
end

task :default  => :specs

desc "reset the db"
task "db:reset" do
  Rake::Task['db:drop'].execute
  Rake::Task['db:create'].execute
  Rake::Task['db:migrate'].execute
  Rake::Task['db:populate'].execute
end
