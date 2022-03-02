module Schash
  module Schema
    module Rule
      class ArrayOf < Base
        def initialize(rule)
          @rule = if rule.is_a?(::Hash)
                    Rule::Hash.new(rule)
                  else
                    rule
                  end
        end

        def validate(target, position = [], strict: false)
          errors = []

          unless target.is_a?(Array)
            errors << Error.new(position, "is not an array")
            return errors
          end

          errors += target.each_with_index.map do |t, i|
            @rule.validate(t, position + [i], strict: strict)
          end.flatten

          errors
        end
      end
    end
  end
end

