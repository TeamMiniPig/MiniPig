class Roster < ActiveRecord::Base
  belongs_to :hoonta
  has_many :users 
end
