module Schash
  module Schema
    module Rule
      class Optional < Base
        def initialize(rule)
          @rule = rule
        end

        def validate(target, position = [], strict: false)
          @rule.validate(target, position, strict: strict)
        end

        def optional?
          true
        end
      end
    end
  end
end

