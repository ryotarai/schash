module Schash
  module Schema
    module Rule
      class Optional < Base
        def initialize(rule)
          @rule = rule
        end

        def validate(target, position = [])
          @rule.validate(target, position)
        end

        def optional?
          true
        end
      end
    end
  end
end

