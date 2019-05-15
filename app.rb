class App
  def call(env)
    path = env['REQUEST_PATH']
    query = URI.unescape(env['QUERY_STRING'])

    response(path, query)
  end

  private

  def response(path, query)
    [status, headers, body(path, query)]
  end

  def status
    200
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def body(path, query)
    [path, query]
  end
end
