module Schash
  class Validator
    def initialize(&schema_block)
      @validator = Schema::Rule::Hash.new(Schema::DSL.evaluate(&schema_block))
    end

    def validate(target, strict: false)
      @validator.validate(target, strict: strict)
    end
  end
end

