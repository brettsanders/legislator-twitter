class CreateLegislators < ActiveRecord::Migration
  def change
    create_table :legislators do |t|
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :party
      t.string :state
      t.string :in_office
      t.string :gender
      t.string :phone
      t.string :twitter_id

      t.timestamps
    end
  end
end
