class CreateActivities < ActiveRecord::Migration
  def change

    create_table :activities do |t|

      t.string :activity_name
      t.string :activity_description
      t.boolean :stay_in

      t.integer :user_id
      t.integer :category_id

    end
  end
end
