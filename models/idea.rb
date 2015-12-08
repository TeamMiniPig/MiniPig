class Idea < ActiveRecord::Base
  belongs_to :user
  belongs_to :category

end


# activities:
#   id
#   activity_name
#   going_out BOOLEAN
#   category_id
#   user_id
