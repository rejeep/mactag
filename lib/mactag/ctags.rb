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

      system "cd #{Rails.root} && #{binary}"
    end
  end
end
