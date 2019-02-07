class Location < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :city, :other

end 
