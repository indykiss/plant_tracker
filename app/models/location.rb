class Plant < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :type

end 
