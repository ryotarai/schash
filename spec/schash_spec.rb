require 'spec_helper'

describe Schash::Validator do
  let(:schema) do
    proc do
      {
        data: {
          string: string,
          not_string: string,
          words: array_of(string),
          not_array: array_of(string),
          required_missing: string,
          optional_missing: optional(string),
          optional_type_error: optional(string),
          numeric: numeric,
          not_numeric: numeric,
          hash: {
            required_missing: string,
          },
          array_of_hash: array_of({
            required_missing: string,
          }),
          boolean: boolean,
          not_boolean: boolean,
          match: match(/^pattern$/),
          not_match: match(/^pattern$/)
        }
      }
    end
  end
  subject { described_class.new(&schema) }

  describe "#validate" do
    context "with invalid data" do
      it "returns errors" do
        errors = subject.validate({
          data: {
            string: "string",
            not_string: 1,
            words: [1],
            not_array: 1,
            optional_type_error: 1,
            numeric: 1,
            not_numeric: "not numeric",
            hash: {
            },
            array_of_hash: [{}],
            boolean: true,
            not_boolean: "string",
            match: "pattern",
            not_match: "not match pattern"
          },
        })

        expected = [
          [
            ["data", "not_string"],
            "is not String",
          ],
          [
            ["data", "words", 0],
            "is not String",
          ],
          [
            ["data", "not_array"],
            "is not an array",
          ],
          [
            ["data", "required_missing"],
            "is required but missing",
          ],
          [
            ["data", "optional_type_error"],
            "is not String",
          ],
          [
            ["data", "not_numeric"],
            "is not Numeric",
          ],
          [
            ["data", "hash", "required_missing"],
            "is required but missing",
          ],
          [
            ["data", "array_of_hash", 0, "required_missing"],
            "is required but missing",
          ],
          [
            ["data", "not_boolean"],
            "is not any of TrueClass, FalseClass",
          ],
          [
            ["data", "not_match"],
            "does not match /^pattern$/",
          ]
        ]

        expect(errors.size).to eq(expected.size)
        errors.each_with_index do |error, i|
          expect(error.position).to eq(expected[i][0])
          expect(error.message).to  eq(expected[i][1])
        end
      end
    end
  end
end
