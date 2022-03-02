module Schash
  module Schema
    module Rule
      class Match < Base
        def initialize(pattern)
          @pattern = pattern
        end

        def validate(target, position = [], strict: false)
          errors = []

          unless @pattern.match(target)
            errors << Error.new(position, "does not match #{@pattern.inspect}")
          end

          errors
        end
      end
    end
  end
end
