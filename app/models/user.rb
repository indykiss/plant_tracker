class User < ActiveRecord::Base
  has_many :plants
  has_many :decorations, through: :plants
  has_secure_password
  validates_presence_of :email, :name, :password


# Need to validate? Validation method, to restrict
# Need to add validate to controllers and views


end
