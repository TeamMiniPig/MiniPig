class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.string :deadline
      t.integer :user_id
      t.integer :hoonta_id
    end
  end
end
