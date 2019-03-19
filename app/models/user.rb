class User < ActiveRecord::Base
  has_many :plants
  has_many :decorations, through: :plants
  has_secure_password
  validates_presence_of :email, :name, :password
  validates_uniqueness_of :email


end
