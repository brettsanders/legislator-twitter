class CreateTweets < ActiveRecord::Migration
  def change
    create_table :tweets do |t|
      t.string :text
      t.belongs_to :legislator
      
      t.timestamps
    end
  end
end
