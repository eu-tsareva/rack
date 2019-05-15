class App
  FORMATS = %w[year month day hour minute second].freeze

  def call(env)
    path = env['REQUEST_PATH']
    query = CGI.unescape(env['QUERY_STRING'])

    response(path, query)
  end

  private

  def response(path, query)
    return page_not_found_response if path != '/time'
    return unknown_query_response if query_attr(query) != 'format'

    formats = query_vals(query)
    unknown = unknown_formats(formats)
    if unknown.any?
      unknown_formats_response(unknown)
    else
      formatted_time_reponse(formats)
    end
  end

  def headers
    { 'Content-Type' => 'text/plain' }
  end

  def query_attr(query)
    query.split('=')[0]
  end

  def query_vals(query)
    query.split('=')[1].split(',')
  end

  def unknown_formats(formats)
    formats - FORMATS
  end

  def page_not_found_response
    [404, headers, ['Page not found']]
  end

  def unknown_query_response
    [400, headers, ['Unknown query']]
  end

  def unknown_formats_response(formats)
    [400, headers, ["Unknown time formats: [#{formats.join(', ')}]"]]
  end

  def formatted_time_reponse(formats)
    time = Time.now
    body = formats.map { |f| time.send(f) }.join('-')
    [200, headers, [body]]
  end

end
