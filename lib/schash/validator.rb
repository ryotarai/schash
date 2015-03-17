module Schash
  class Validator
    def initialize(&schema_block)
      @validator = Schema::Rule::Hash.new(Schema::DSL.evaluate(&schema_block))
    end

    def validate(target)
      @validator.validate(target)
    end
  end
end

