class TimeQuery
  FORMATS = {
    'year' => 'year',
    'month' => 'month',
    'day' => 'day',
    'hour' => 'hour',
    'minute' => 'min',
    'second' => 'sec'
  }.freeze

  def initialize(formats)
    @formats = formats.split(',')
    @time = Time.now
  end

  def success?
    @formats.any? && unknown_formats.empty?
  end

  def result
    @formats
      .map { |format| @time.send(FORMATS[format]) }
      .join('-')
  end

  def unknown_formats
    @unknown_formats ||= @formats - FORMATS.keys
  end
end
