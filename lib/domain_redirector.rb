class DomainRedirector
  def initialize app
    @app = app
  end

  def call env
    parsed = URI::parse "http://#{env['HTTP_HOST']}"
    if parsed.host != 'test.rubygems.org'

      server_port = if ENV['SERVER_PORT'] == "81"
                      "80"
                    else
                      ENV['SERVER_PORT']
                    end

      [301, {"Location" => "http://test.rubygems.org:#{server_port}#{env['PATH_INFO']}?#{env['QUERY_STRING']}"}, "Redirecting to test.rubygems.org..."]
    else
      @app.call env
    end
  end
end
