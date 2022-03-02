module Schash
  module Schema
    module Rule
      class Hash < Base
        def initialize(schema_hash)
          @schema_hash = schema_hash
        end

        def validate(target, position = [], strict: false)
          errors = @schema_hash.map do |key, rule|
            if rule.is_a?(::Hash)
              rule = self.class.new(rule)
            end

            found_key = [key.to_s, key.to_sym].find do |k|
              target.has_key?(k)
            end

            if found_key
              rule.validate(target[found_key], position + [key.to_s], strict: strict)
            else
              unless rule.optional?
                Error.new(position + [key.to_s], "is required but missing")
              end
            end
          end
          if strict
            target.each_key do |key|
              found_key = [key.to_s, key.to_sym].find do |k|
                @schema_hash.key?(k)
              end
              if !found_key
                errors.append(Error.new(position + [key.to_s], "is not in schema"))
              end
            end
          end
          errors.flatten.compact
        end
      end
    end
  end
end

