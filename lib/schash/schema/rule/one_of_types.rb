module Schash
  module Schema
    module Rule
      class OneOfTypes < Base
        def initialize(*klasses)
          @klasses = klasses
        end

        def validate(target, position = [])
          match = @klasses.any? do |klass|
            target.is_a?(klass)
          end

          if match
            []
          else
            [Error.new(position, "is not any of #{@klasses.map(&:to_s).join(', ')}")]
          end
        end
      end
    end
  end
end

