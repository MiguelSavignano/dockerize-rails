class JsonFormatter < ::Logger::Formatter
  def call(severity, time, program_name, message)
    "#{json_format(severity, time, program_name, message).to_json}\n"
  end

  def parse_message(message = "")
    begin
      JSON.parse(message)
    rescue
      message
    end
  end

  def json_format(severity, time, program_name, message)
    {
      name: ENV['SERVICE_NAME'] || program_name,
      # hostname: ENV['SERVICE_HOSTNAME'] || '',
      # pid: $$,
      level: severity,
      time: time.to_i,
      message: parse_message(message),
      # v: 1
    }
  end
end
