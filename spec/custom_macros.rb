module CustomMacros
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    def it_should_support_dsl(description, &block)
      it "should support dsl #{description}" do
        lambda {
          instance_eval(&block)
        }.should_not raise_exception
      end
    end
  end
end
