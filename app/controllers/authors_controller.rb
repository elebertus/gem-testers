class AuthorsController < ApplicationController
  def gems
    @gems = sort_gems(Author.where(:id => params[:id]).first.rubygems)
    render 'browse/gems'
  end
end
