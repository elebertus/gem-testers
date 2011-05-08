class BrowseController < ApplicationController
  def index
    redirect_to :browse_gems
  end

  def gems
    @gems = sort_gems(Rubygem)
  end

  def authors
    @authors = sort_authors(Author)
  end
end
