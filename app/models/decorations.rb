class Decoration < ActiveRecord::Base
  belongs_to :plant
  validates_presence_of :dec_name


end
