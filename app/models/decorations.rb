class Decoration < ActiveRecord::Base
  belongs_to :plant
  validates_presence_of :dec_name
  validates_uniqueness_of :dec_name

end
