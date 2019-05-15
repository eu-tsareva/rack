require_relative 'response'

class TimeApp
  FORMATS = {
    'year' => 'year',
    'month' => 'month',
    'day' => 'day',
    'hour' => 'hour',
    'minute' => 'min',
    'second' => 'sec'
  }.freeze

  def initialize(query)
    query_str = query.split('=')
    @param = query_str[0]
    @values = query_str[1].split(',')
  end

  def call
    if @param != 'format'
      return Response.new(
        status: 400,
        body: 'Unknown query'
      ).call
    end

    if unknown_formats.any?
      Response.new(
        status: 400,
        body: "Unknown formats [#{unknown_formats.join(', ')}] "
      ).call
    else
      Response.new(
        status: 200,
        body: formatted_time
      ).call
    end
  end

  private

  def unknown_formats
    @unknown_formats ||= @values - FORMATS.keys
  end

  def formatted_time
    time = Time.now
    @values
      .map { |format| time.send(FORMATS[format]) }
      .join('-')
  end
end
