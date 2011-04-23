class BrowseController < ApplicationController
  def index

    order_by = :name

    if params[:order_by] and [:name, :versions, :test_results].include?(params[:order_by].to_sym)
      order_by = params[:order_by].to_sym
    end

    if order_by != :name
      join = Rubygem.joins(order_by)
      group = join.group("#{order_by}.rubygem_id")
      order = group.select("rubygems.id, count(#{order_by}.rubygem_id) as order_by_count")
      page = order.order("order_by_count DESC")
      @gems = page.page(params[:page] || 0, :include => [:versions, :test_results])
      @gems.map(&:reload)
    else
      @gems = Rubygem.order(order_by).page(params[:page] || 0)
    end
  end
end
