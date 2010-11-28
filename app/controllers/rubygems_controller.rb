class RubygemsController < ApplicationController
  def index
    unless request.xhr?
      @rubygems = Rubygem.all
    else
      @rubygems = Rubygem.where(['name LIKE ?', "%#{params[:term]}%"]).all
      gem_names = @rubygems.collect { |gem| gem.name }
      render :json => gem_names
    end
  end

  def show
    get_rubygem params[:id]
    @test_results = TestResult.where(:rubygem_id => @rubygem.id).all
    fill_results_page
  end

end
