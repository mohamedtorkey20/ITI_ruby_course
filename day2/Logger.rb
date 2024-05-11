module  Logger
  def self.log_info(message)
    append_log_to_file("info",message)
  end
  def self.log_warning(message)
    append_log_to_file("warning",message)
  end
  def self.log_error(message)
    append_log_to_file("error",message)

  end

  def self.append_log_to_file(type,message)
    timestamp=Time.now.utc.strftime("%Y%m%d%H%M%S")
    log="#{timestamp} -- #{type} -- #{message}\n"

    file = File.new("app.log", "a")
    file.puts(log)
    file.close
    end


end

