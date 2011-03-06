class DomainRedirector
  def initialize app
    @app = app
  end

  def call env
    parsed = URI::parse "http://#{env['HTTP_HOST']}"
    if parsed.host != 'test.rubygems.org'
      [301, {"Location" => "http://test.rubygems.org:#{env['SERVER_PORT']}#{env['PATH_INFO']}?#{env['QUERY_STRING']}"}, "Redirecting to test.rubygems.org..."]
    else
      @app.call env
    end
  end
end
