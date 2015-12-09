class CreateVotes < ActiveRecord::Migration
  def change

    create_table :votes do |t|
      t.integer :user_id
      t.integer :idea_id
      
    end
  end
end
