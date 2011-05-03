class Version < ActiveRecord::Base
  has_many :test_results
  belongs_to :rubygem

  validates_uniqueness_of :number, scope: [:rubygem_id]
  validates_presence_of :number, :rubygem_id
  
  before_save :check_prerelease
  after_save :retrieve_current_authors_of_gem, if: proc {self >= self.rubygem.latest_version}

  def check_prerelease
    self.prerelease = false if self.prerelease.nil?
    not self.prerelease.nil?
  end

  def pass_count
    TestResult.where(result: true, version_id: self.id).count
  end

  def fail_count
    TestResult.where(result: false, version_id: self.id).count
  end

  def retrieve_current_authors_of_gem
    self.rubygem.retrieve_authors
  end
  
  def gem_version
    @gem_version = Gem::Version.new(self.number)
  end
  
  def <=> other
    self.gem_version <=> other.gem_version
  end

  def >= other
    (self <=> other) != -1
  end
end
