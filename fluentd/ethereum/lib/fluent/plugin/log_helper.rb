

module LocalLogger
    @fluentLoggerExists = !!Fluent::Log rescue false
    log = Fluent::Log
    # if !@fluentLoggerExists 
      def debug (message)
        print_and_flush("[DEBUG]: ", message)
      end

      def logInfo (message)
        print_and_flush("[INFO ]: ", message)
      end

      def logWarn (message)
        print_and_flush("[WARN ]: ", message)
      end
      
      def logError (message)
        print_and_flush("[ERROR]: ", message)
      end
    
    # else 
    #   def debug (message)
    #     log.debug (message)
    #   end

    #   def logInfo (message)
    #     log.info (message)
    #   end

    #   def logWarn (message)
    #     log.warn(message)
    #   end
      
    #   def logError (message)
    #     log.error(message)
    #   end

    # end
    
    private 

    def print_and_flush(prefix, str)
      print "#{prefix} #{str}\n"
      $stdout.flush
    end
      
end