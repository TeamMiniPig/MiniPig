class Hoonta < ActiveRecord::Base

  self.table_name = "hoontas";
  has_many :users, through: :rosters
end

# hoontas:
#   id
#   hoonta_name
