class Author < ActiveRecord::Base
  has_many :rubygems, through: :authorships
  has_many :authorships
  
  validates_presence_of :name
  validates_uniqueness_of :name
end
