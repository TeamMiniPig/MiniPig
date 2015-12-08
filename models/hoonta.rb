class Hoonta < ActiveRecord::Base

  self.table_name = "hoontas";
  has_many :users
  has_many :activities, through: :users
end

# hoontas:
#   id
#   hoonta_name
