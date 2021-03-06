class TestResultsController < ApplicationController

  protect_from_forgery :except => :create

  def index
    if params[:rubygem_id]
      @rubygem = Rubygem.first(conditions: {name: params[:rubygem_id]})
      @version = Version.first(conditions: {rubygem_id: @rubygem.id, number: params[:version_id]}) if @rubygem
      if @version
        redirect_to rubygem_version_path(@rubygem.name, @version.number) and return
      else
        flash[:notice] = "Can't find any results with for '#{params[:rubygem_id]}' v #{params[:version_id]}"
        redirect_to rubygems_path and return
      end
    end

    respond_to do |format|
      format.json do
        q = TestResult.where('created_at > ?', 1.hour.ago)
        render json: {
          pass_count: q.where(result: true).count,
          fail_count: q.where(result: false).count,
          test_results: q.order('created_at DESC').all.collect(&:short_attributes)
        }
      end
      format.html
    end
  end

  def create
    @response = Response.new

    @result_details = YAML::load params[:results]
    bubble_errors_from(@gem = Rubygem.find_or_create_by_name(@result_details[:name])) if @result_details

    if @result_details[:version]
      if @gem and @gem.valid?
        conditions = {number: @result_details[:version][:release], rubygem_id: @gem.id}
        conditions.merge(prerelease: @result_details[:version][:prerelease]) unless @result_details[:version][:prerelease].nil?
        @v = Version.where(conditions).first
        unless @v
          bubble_errors_from(@v = Version.create!(number: @result_details[:version][:release], prerelease: @result_details[:version][:prerelease], rubygem: @gem))
        end
      end
    else
      @response.errors.add :'Version', 'can\'t be blank'
    end
    
    bubble_errors_from(@result = TestResult.create(result_attributes_from(@result_details))) if @gem and @gem.valid? and @v and @v.valid?
    
    headers['Content-Type'] = 'application/x-yaml'
    
    @response.success = (@response.errors.count == 0)
    @response.data << rubygem_version_test_result_url(@gem.name, @v.number, @result) if @response.success

    render text: @response.to_yaml
  end

  def show
 
    # HACK HACK HACK
    # please see the comments relating to the json problem in the versions
    # controller's show action
    # HACK HACK HACK
    
    result_id = params[:id]

    if params[:id] =~ /\.json$/
      result_id = params[:id].sub(/\.json$/, '')
      request.format = :json
    end

    @result = TestResult.where(id: result_id).first

    if @result.nil? and request.format != :json
      flash[:notice] = "We could not locate that test result."
      (redirect_to :back rescue redirect_to root_url) and return
    end

    respond_to do |format|
      format.json { render json: (@result || {}) }
      format.html
    end
  end
  
  private

  def bubble_errors_from object
    @response.merge_errors object.errors, object_name: object.class.name
  end
  
  def result_attributes_from result_details
    attributes = {}
    attributes[:architecture]         = result_details[:arch]
    attributes[:vendor]               = result_details[:vendor]
    attributes[:machine_architecture] = result_details[:machine_arch]
    attributes[:operating_system]     = result_details[:os]
    attributes[:test_output]          = result_details[:test_output]
    attributes[:ruby_version]         = result_details[:ruby_version]
    attributes[:result]               = result_details[:result]
    attributes[:platform]             = result_details[:platform]
    attributes[:rubygems_test_version] = result_details[:rubygems_test_version]
    attributes[:rubygem]              = @gem
    attributes[:version]              = @v
    
    attributes
  end
end
