class Response
  STATUS = {
    200 => 'OK',
    404 => 'Page not found',
    400 => 'Bad request'
  }.freeze

  def initialize(status:, headers: headers_default, body: STATUS[status])
    @status = status
    @headers = headers
    @body = body
  end

  def headers_default
    { 'Content-Type' => 'text/plain' }
  end

  def call
    [@status, @headers, [@body]]
  end
end
