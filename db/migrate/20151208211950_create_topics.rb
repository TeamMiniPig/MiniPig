class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.string :topic_name
      t.string :deadline

      t.integer :hoonta_id
      t.integer :category_id
    end
  end
end
