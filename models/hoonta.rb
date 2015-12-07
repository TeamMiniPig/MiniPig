class Hoonta < ActiveRecord::Base
  has_many :users
  has_many :activities, through: :users
end

# hoontaes:
#   id
#   hoonta_name
