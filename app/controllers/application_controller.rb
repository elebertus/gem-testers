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
      inner_hash = (os_matrix[result.ruby_version] ||= {})[OSTranslator.translate(result.operating_system)] ||= {}
      inner_hash[:pass] ||= 0 
      inner_hash[:fail] ||= 0 
      inner_hash[result.result ? :pass : :fail] += 1
    end
    os_matrix
  end
 
  #
  # FIXME Not sure how to best abstract these two routines into one and have it
  #       not suck(tm).
  #
  # -Erik
  #
  def sort_gems(gems)
    order_by = :name

    if params[:order_by] and [:name, :versions, :test_results].include?(params[:order_by].to_sym)
      order_by = params[:order_by].to_sym
    end

    if order_by != :name
      join = gems.joins(order_by)
      group = join.group("#{order_by}.rubygem_id")
      order = group.select("rubygems.id, count(#{order_by}.rubygem_id) as order_by_count")
      page = order.order("order_by_count DESC")
      paged_gems = page.page(params[:page] || 0, :include => [:versions, :test_results])
      paged_gems.each(&:reload)
      return paged_gems
    else
      return gems.order(order_by).page(params[:page] || 0, :include => [:versions, :test_results])
    end
  end

  def sort_authors(authors)
    order_by = :name

    if params[:order_by] and [:name, :versions, :test_results].include?(params[:order_by].to_sym)
      order_by = params[:order_by].to_sym
    end

    if order_by != :name
      join = authors.joins(:rubygems => [order_by])
      group = join.group("authors.id")
      order = group.select("authors.id, count(#{order_by}.rubygem_id) as order_by_count")
      page = order.order("order_by_count DESC")
      paged_authors = page.page(params[:page] || 0, :include => { :rubygems => [:versions, :test_results] })
      paged_authors.each(&:reload)
      return paged_authors 
    else
      return authors.order(order_by).page(params[:page] || 0, :include => { :rubygems => [:versions, :test_results] })
    end
  end
end
