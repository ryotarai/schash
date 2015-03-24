module Schash
  module Schema
    class DSL
      def self.evaluate(&block)
        self.new.instance_eval(&block)
      end

      def array_of(schema)
        Rule::ArrayOf.new(schema)
      end

      def one_of_types(*schemas)
        Rule::OneOfTypes.new(*schemas)
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

      def integer
        type(Integer)
      end

      def float
        type(Float)
      end

      def symbol
        type(Symbol)
      end

      def array
        type(Array)
      end

      def boolean
        one_of_types(TrueClass, FalseClass)
      end
    end
  end
end

