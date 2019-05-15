require_relative 'response'
require_relative 'time_app'

class App
  def call(env)
    path = env['REQUEST_PATH']
    query = CGI.unescape(env['QUERY_STRING'])

    route(path, query)
  end

  private

  def route(path, query)
    return Response.new(status: 404).call if path != '/time'

    TimeApp.new(query).call
  end
end
