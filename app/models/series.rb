class Series < ActiveRecord::Base
  include UUIDHelper

  has_many :books
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
