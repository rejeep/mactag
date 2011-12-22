module CustomMacros
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def it_supports_dsl(description = nil, &block)
      it "supports dsl #{description}" do
        lambda {
          instance_eval(&block)

          builder = @dsl.instance_variable_get('@builder')
          tags = builder.instance_variable_get('@tags')

          tags.should_not be_empty
        }.should_not raise_exception
      end
    end

    def it_does_not_support_dsl(description = nil, &block)
      it "does not support dsl #{description}" do
        lambda {
          instance_eval(&block)
        }.should raise_exception(ArgumentError)
      end
    end
  end
end
