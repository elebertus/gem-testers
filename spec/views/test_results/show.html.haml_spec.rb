require 'spec_helper'

describe "test_results/show.html.haml" do
  before(:each) do
    @gem = Factory.create :rubygem
  end

  it "should display a prerelease badge when version tested is a prerelease" do
    @version = Factory.create :version, rubygem: @gem, prerelease: true
    @result = Factory.create :test_result, version: @version, rubygem: @gem
    assign(:result, @result)

    render

    rendered.should match(/prerelease/)
  end
  
  it "should not display a prerelease badge when version tested is full release" do
    @version = Factory.create :version, rubygem: @gem, prerelease: false
    @result = Factory.create :test_result, version: @version, rubygem: @gem
    assign(:result, @result)

    render

    rendered.should_not match(/prerelease/)
  end

  it 'should display the rubygems_test_version if it exists' do
    @v = Factory.create :version, rubygem: @gem
    @t = Factory.create :test_result, version: @v, rubygem: @gem
    assign(:result, @t)

    render

    rendered.should match(/via rubygems-test v#{@t.rubygems_test_version}/)
  end

  
  it 'should not display the rubygems_test_version context text if it does not exist' do
    @v = Factory.create :version, rubygem: @gem
    @t = Factory.create :test_result, version: @v, rubygem: @gem, rubygems_test_version: nil
    assign(:result, @t)

    render

    rendered.should_not match(/via rubygems-test v/)
  end
end

