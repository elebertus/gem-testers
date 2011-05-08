class BrowseController < ApplicationController
  def index
    redirect_to :browse_gems
  end

  def gems
    @gems = sort_gems(Rubygem)
  end

  def authors
    @authors = Author.page(params[:page] || 0, :include => [:rubygems => [ :versions, :test_results ] ])
  end
end
