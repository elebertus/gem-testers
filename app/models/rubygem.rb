class Rubygem < ActiveRecord::Base
  paginates_per 50

  # routes can't include ^/$ in a constraint
  ROUTE_MATCHER = /[A-Za-z0-9\-\_\.]+/
  NAME_MATCHER = /^#{ROUTE_MATCHER}$/
  
  validates_uniqueness_of :name
  validates_format_of :name, with: NAME_MATCHER

  has_many :test_results
  has_many :versions
  has_many :authors, through: :authorships, class_name: 'User'
  has_many :authorships
  
  def pass_count
    TestResult.where(result: true, rubygem_id: self.id).count
  end

  def fail_count
    TestResult.where(result: false, rubygem_id: self.id).count
  end

  def retrieve_authors
    data = GemCutter.gem_data self.name
    authors = data['authors'].split(',').collect { |author| User.new(name: author.strip) }
    self.authors = authors
  end

  def latest_version
    self.versions.sort.last
  end
  
end
