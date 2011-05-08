require 'spec_helper'

describe User do
  it 'should require a name' do
    User.new(name: 'thename').save.should be_true
  end
  it 'should error when missing a handle' do
    User.new.save.should be_false
    User.new(name: '').save.should be_false
  end
end
