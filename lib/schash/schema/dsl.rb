module Schash
  module Schema
    class DSL
      def self.evaluate(&block)
        self.new.instance_eval(&block)
      end

      def array_of(schema)
        Rule::ArrayOf.new(schema)
      end

      def type(klass)
        Rule::Type.new(klass)
      end

      def optional(rule)
        Rule::Optional.new(rule)
      end

      def string
        type(String)
      end

      def numeric
        type(Numeric)
      end
    end
  end
end

