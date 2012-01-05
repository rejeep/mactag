module Matcher
  class RailsIndex
    def initialize(*args)
      if args.last.is_a?(Hash)
        @version = args.last[:version]

        args.pop
      end

      @packages = args
    end

    def matches?(dsl)
      @actual = dsl.builder.tags.first

      same_packages? && same_version?
    end

    def failure_message
      "expected '#{@actual.inspect}' to equal '#{@packages}/#{@version}' but did not"
    end

    def negative_failure_message
      "expected '#{@actual.inspect}' to not equal '#{@packages}/#{@version}' but did"
    end

    private

    def same_version?
      if @version
        @actual.version == @version
      else
        true
      end
    end

    def same_packages?
      @actual.packages - @packages == @packages - @actual.packages
    end
  end

  def have_rails_index(*args)
    RailsIndex.new(*args)
  end
end
