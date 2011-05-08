class Authorship < ActiveRecord::Base
  belongs_to :rubygem
  belongs_to :author
  
  validates_presence_of :author_id, :rubygem_id
end
