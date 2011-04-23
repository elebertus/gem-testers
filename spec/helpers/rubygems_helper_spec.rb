require 'spec_helper'
describe RubygemsHelper do
  it 'should sort versions properly' do
    g = Factory.create :rubygem
    Factory.create :version, rubygem: g, number: '2.0'
    Factory.create :version, rubygem: g, number: '2.0rc', prerelease: true
    Factory.create :version, rubygem: g, number: '1.0'
    Factory.create :version, rubygem: g, number: '1.0rc', prerelease: true
    Factory.create :version, rubygem: g, number: '3.0'
    Factory.create :version, rubygem: g, number: '3.0rc', prerelease: true
    versions = get_versions g, nil
    versions.shift
    ['1.0rc', '1.0', '2.0rc', '2.0', '3.0rc', '3.0'].reverse.each.with_index do |number, i|
      versions[i].first.should == number
    end
  end
end
