module Mactag
  ##
  #
  # Wrapper around Ctags command.
  #
  class Ctags
    def initialize(input, output)
      @input = input
      @output = output
    end

    def create
      binary = Mactag::Config.binary

      binary.gsub!('{OUTPUT}', @output)
      binary.gsub!('{INPUT}', @input)
      
      exec(binary)
    end
    
    
    private
    
    def exec(binary)
      system command(binary)
    end
    
    def command(binary)
      "cd #{Rails.root} && #{binary}"
    end
  end
end
