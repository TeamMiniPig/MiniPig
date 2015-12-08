class CreateRosters < ActiveRecord::Migration
  def change
    create_table :rosters do |t|
      t.integer :user_id
      t.integer :hoonta_id
    end
  end
end
