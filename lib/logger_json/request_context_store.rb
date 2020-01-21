module LoggerJson
  class RequestContextStore
    def self.get(key)
      Thread.current[key]
    end
  end
end
