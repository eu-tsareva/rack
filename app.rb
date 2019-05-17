require_relative 'time_query'

class App
  def call(env)
    request = Rack::Request.new(env)

    if request.path_info == '/time'
      handle_valid_request(request.params['format'])
    else
      handle_invalid_request
    end
  end

  private

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def handle_invalid_request
    Rack::Response.new(['Page not found'], 404, headers)
  end

  def handle_valid_request(params)
    time_query = TimeQuery.new(params)

    if time_query.success?
      Rack::Response.new([time_query.result], 200, headers)
    else
      Rack::Response.new(
        ["Unknown formats [#{time_query.unknown_formats.join(', ')}]"],
        400,
        headers
      )
    end
  end
end
