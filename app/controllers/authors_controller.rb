class AuthorsController < ApplicationController
  def gems
    @gems = Author.where(:id => params[:id]).rubygems.page(params[:page] || 0)
  end
end
