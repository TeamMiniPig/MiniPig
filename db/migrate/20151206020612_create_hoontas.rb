class CreateHoontas < ActiveRecord::Migration
  def change

    create_table :hoontas do |t|

      t.string :hoonta_name
      t.string :hoonta_password

      t.integer :user_id

    end
  end
end
