require 'spec_helper'

describe Author do
  it 'should require a name' do
    Author.new(name: 'thename').save.should be_true
  end
  it 'should error when missing a handle' do
    Author.new.save.should be_false
    Author.new(name: '').save.should be_false
  end
end
