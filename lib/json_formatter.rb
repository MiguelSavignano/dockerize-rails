require_relative './request_context_store'
class JsonFormatter < ::Logger::Formatter

  def initialize(request_store = RequestContextStore)
    @request_store = request_store
    super()
  end

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
      severity: severity,
      time: time.to_i,
      request_id: request_id
      message: parse_message(message),
      # v: 1
    }
  end

  def request_id
    @request_store.get(RequestIdLogging::FIBER_LOCAL_KEY)
  end
end
