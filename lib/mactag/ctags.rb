module Mactag
  ##
  #
  # Wrapper around Ctags command.
  #
  class Ctags
    def initialize(input, output)
      @input = Array(input)
      @output = output
    end

    def create
      system(command)
    end


    private
    
    def command
      "cd #{Rails.root} && #{binary}"
    end

    def binary
      binary = Mactag::Config.binary

      binary.gsub!('{OUTPUT}', @output)
      binary.gsub!('{INPUT}', @input.join(' '))
      
      binary
    end
  end
end
