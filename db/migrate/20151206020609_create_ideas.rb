class CreateIdeas < ActiveRecord::Migration
  def change

    create_table :ideas do |t|

      t.string :idea_name
      t.string :idea_description

      t.integer :user_id
      t.integer :category_id
      t.integer :hoonta_id

    end
  end
end
