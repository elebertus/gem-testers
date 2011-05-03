class User < ActiveRecord::Base
  has_many :rubygems, through: :ownerships
  has_many :authorships
  
  validates_presence_of :name
end
