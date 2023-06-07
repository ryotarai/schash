module Schash
  module Schema
    module Rule
      class Optional < Base
        def initialize(rule)
          @rule = if rule.is_a?(::Hash)
                    Rule::Hash.new(rule)
                  else
                    rule
                  end
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

