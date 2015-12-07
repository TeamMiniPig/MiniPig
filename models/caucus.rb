class Caucus < ActiveRecord::Base
  self.table_name = "caucuses"
  has_many :users
  has_many :activities, through: :users
end

# caucuses:
#   id
#   caucus_name
