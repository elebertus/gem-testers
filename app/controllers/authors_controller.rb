class AuthorsController < ApplicationController
  def gems
    @gems = Author.where(:id => params[:id]).first.rubygems.page(params[:page] || 0)
    render 'browse/gems'
  end
end
