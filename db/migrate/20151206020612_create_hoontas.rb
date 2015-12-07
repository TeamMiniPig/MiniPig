class CreateHoontas < ActiveRecord::Migration
  def change

    create_table :hoontas do |t|

      t.string :hoonta_name

      t.string :current_topic
      t.boolean :has_deadline
      t.string :deadline
      t.boolean :has_password
      t.string :hoonta_password

    end
  end
end
