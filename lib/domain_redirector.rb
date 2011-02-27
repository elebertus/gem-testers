class DomainRedirector
  def initialize app
    @app = app
  end

  def call env
    if env['SERVER_NAME'] != 'test.rubygems.org'
      [301, {"Location" => "http://test.rubygems.org:#{env['SERVER_PORT']}#{env['PATH_INFO']}"}, "Redirecting to test.rubygems.org..."]
    else
      @app.call env
    end
  end
end
