class AuthorsController < ApplicationController
  def gems
    @author = Author.where(:id => params[:id]).first
    @gems = sort_gems(@author.rubygems)
    render 'browse/gems'
  end
end
