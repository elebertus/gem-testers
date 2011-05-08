class Author < ActiveRecord::Base
  paginates_per 50

  has_many :rubygems, through: :authorships
  has_many :authorships
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
