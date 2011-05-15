require 'spec_helper'

describe Author do
  it 'should require a name' do
    Author.new(name: 'thename').save.should be_true
  end
  it 'should error when missing a handle' do
    Author.new.save.should be_false
    Author.new(name: '').save.should be_false
  end

  it 'should error trying to save a second copy of the same name' do
    Author.new(name: 'erik').save.should_not be_false
    Author.new(name: 'erik').save.should be_false
  end

  it 'should respond to kaminari' do
    Author.should respond_to(:page)
  end
end
