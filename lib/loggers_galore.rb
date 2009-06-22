module Rails
  
  class << self
    
    def extra_loggers= loggers
      raise ArgumentError, "Params for loggers -#{loggers.inspect} don't look appropriate #{$@}" unless loggers.is_a?(Array)
      loggers.each do |logger|
        raise ArgumentError unless logger.is_a?(String) || logger.is_a?(Symbol)
        logger = logger.to_s
        raise ArgumentError, "Can't call extra logger test, development or production... that would be confusing" if %w( development test production ).include?(logger)
        path = "#{Rails.root}/log/#{logger.downcase}.log"
        new_file = !File.exist?(path)
        new_logger = ActiveSupport::BufferedLogger.new path
        new_logger.info "" if new_file # => adds a line break if this is a new log
        const = Object.const_set( "%s_LOGGER" % logger.upcase, new_logger )
        # adds this method to Object - the mother of all classes!!!
        Object.send(:define_method, :"#{logger.downcase}_logger") { const }
      end
    end
    
  end
      
end
