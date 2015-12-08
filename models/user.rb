class User < ActiveRecord::Base
  belongs_to :hoonta
  has_many :activities

  include BCrypt

  def password=(pwd)
    self.password_digest = BCrypt::Password.create(pwd)
  end

  def password
    BCrypt::Password.new(self.password_digest)
  end

  

  def self.authenticate user_name, password
    current_user = User.find_by(user_name: user_name)
    if current_user and current_user.password == password
      current_user
    else
      nil
    end
  end

end

# users:
#   id
#   user_name
#   email
#   password_digest
#   hoonta_id
