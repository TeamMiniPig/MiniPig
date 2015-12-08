class CreateHoontas < ActiveRecord::Migration
  def change

    create_table :hoontas do |t|

      t.string :hoonta_name
      t.string :hoonta_password

    end
  end
end
