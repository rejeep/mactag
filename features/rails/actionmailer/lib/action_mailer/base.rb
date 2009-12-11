module ActionMailer #:nodoc:
  class Base
    class << self
      def deliver(mail)
        # ...
      end
    end
  end
end
