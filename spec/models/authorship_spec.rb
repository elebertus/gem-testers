require 'spec_helper'

describe Authorship do
  it 'shouldn\'t allow creation without a rubygem and a user' do
    Authorship.new.save.should be_false
  end
  it 'shouldn\'t allow creation without a rubygem' do
    u = Factory.create :author
    Authorship.new(author_id: u.id).save.should be_false
  end
  it 'shouldn\'t allow creation without a rubygem and a user' do
    r = Factory.create :rubygem
    Authorship.new(rubygem_id: r.id).save.should be_false
  end
  it 'should allow creating with both a rubygem and a user' do
    r = Factory.create :rubygem
    u = Factory.create :author
    Authorship.new(rubygem_id: r.id, author_id: u.id).save.should be_true
  end
end
