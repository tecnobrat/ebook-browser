class Book < ActiveRecord::Base
  include UUIDHelper

  belongs_to :author
  belongs_to :publisher
  belongs_to :series
  has_and_belongs_to_many :tags
  
  validates_uniqueness_of :title, :scope => :author_id
  validates_presence_of :file_name
  validates_presence_of :file_size
  validates_presence_of :title
  validates_presence_of :author_id
end
