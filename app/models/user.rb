class User < ActiveRecord::Base
  has_many :rubygems, through: :ownerships

  validates_presence_of :handle
end
