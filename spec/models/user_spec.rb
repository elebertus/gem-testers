require 'spec_helper'

describe User do
  it 'should require a handle' do
    User.new(handle: 'myhandle').save.should be_true
  end
  it 'should error when missing a handle' do
    User.new.save.should be_false
    User.new(handle: '').save.should be_false
  end
end
