class CreateIdeas < ActiveRecord::Migration
  def change

    create_table :ideas do |t|

      t.string :idea_name

      t.integer :user_id
      t.integer :topic_id

    end
  end
end
