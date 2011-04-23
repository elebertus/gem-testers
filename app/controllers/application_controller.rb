require 'os_translator'

class ApplicationController < ActionController::Base
  protect_from_forgery

  layout :select_layout

  private
  
  def select_layout
    if request.xhr?
      nil
    else
      'application'
    end
  end

  def fill_results_page 
    @os_matrix = populate_os_matrix @test_results
    @ruby_versions = @os_matrix.keys
    @operating_systems = @test_results.collect { |r| OSTranslator.translate(r.operating_system) }.uniq
  end

  def populate_os_matrix test_results
    os_matrix = {}
    test_results.each do |result|
      inner_array = (os_matrix[result.ruby_version] ||= {})[OSTranslator.translate(result.operating_system)] ||= {}
      inner_array[:pass] ||= 0 
      inner_array[:fail] ||= 0 
      inner_array[result.result ? :pass : :fail] += 1
    end
    os_matrix
  end
end
