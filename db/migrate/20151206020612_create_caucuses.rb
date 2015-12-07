class CreateCaucuses < ActiveRecord::Migration
  def change

    create_table :caucuses do |t|

      t.string :caucus_name
      t.boolean :has_password
      t.string :caucus_password

    end
  end
end
