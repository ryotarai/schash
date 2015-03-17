module Schash
  module Schema
    module Rule
      class Type < Base
        def initialize(klass)
          @klass = klass
        end

        def validate(target, position = [])
          errors = []

          unless target.is_a?(@klass)
            errors << Error.new(position, "is not #{@klass}")
          end

          errors
        end
      end
    end
  end
end

