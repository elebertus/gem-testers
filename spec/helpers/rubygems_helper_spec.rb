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
    g.reload
    versions = get_versions g, nil
    versions.shift
    ['1.0rc', '1.0', '2.0rc', '2.0', '3.0rc', '3.0'].reverse.each.with_index do |number, i|
      versions[i].first.should == number
    end
  end

  it 'should select the current platform properly' do
    g = Factory.create :rubygem
    pv = Factory.create :version, rubygem: g, number: '2.0'
    Factory.create :test_result, version: pv, platform: 'java'
    Factory.create :version, rubygem: g, number: '2.0rc', prerelease: true
    Factory.create :version, rubygem: g, number: '1.0'
    Factory.create :version, rubygem: g, number: '1.0rc', prerelease: true
    v = Factory.create :version, rubygem: g, number: '3.0'
    Factory.create :version, rubygem: g, number: '3.0rc', prerelease: true
    g.reload

    current_platform(nil, g, v).should == rubygem_version_path(g.name, '3.0')
    current_platform('java', g, pv).should == rubygem_version_path(g.name, '2.0', :platform => 'java')
    current_platform(nil, g, nil).should == rubygem_path(g.name)
    current_platform('java', g, nil).should == rubygem_path(g.name, :platform => 'java')
  end
end
