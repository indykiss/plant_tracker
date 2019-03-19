class Plant < ActiveRecord::Base
  belongs_to :user
  has_many :decorations
  validates_presence_of :name

end
