class Rubygem < ActiveRecord::Base
  paginates_per 50

  # routes can't include ^/$ in a constraint
  ROUTE_MATCHER = /[A-Za-z0-9\-\_\.]+/
  NAME_MATCHER = /^#{ROUTE_MATCHER}$/
  
  validates_uniqueness_of :name
  validates_format_of :name, with: NAME_MATCHER

  has_many :test_results
  has_many :versions
  has_many :authors, through: :ownerships, class_name: 'User'
  
  def pass_count
    TestResult.where(result: true, rubygem_id: self.id).count
  end

  def fail_count
    TestResult.where(result: false, rubygem_id: self.id).count
  end
  
end
