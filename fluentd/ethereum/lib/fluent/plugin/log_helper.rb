

module LocalLogger

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

    private 

    def print_and_flush(prefix, str)
      print "#{prefix} #{str}\n"
      $stdout.flush
    end
      
end