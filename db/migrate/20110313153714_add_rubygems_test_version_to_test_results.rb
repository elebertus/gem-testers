class AddRubygemsTestVersionToTestResults < ActiveRecord::Migration
  def self.up
    add_column :test_results, :rubygems_test_version, :string
  end

  def self.down
    remove_column :test_results, :rubygems_test_version
  end
end
