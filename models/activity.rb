class Activity < ActiveRecord::Base
  belongs_to :user
  has_one :caucus, through: :user
  has_one :category

end


# activities:
#   id
#   activity_name
#   going_out BOOLEAN
#   category_id
#   user_id
