class Authorship < ActiveRecord::Base
  validates_presence_of :user_id, :rubygem_id
end
