# frozen_string_literal: true

RSpec::Matchers.define :match_json_schema do |schema|
  match do |json|
    schema_directory = Rails.root.join('spec/schemas')
    schema_path = "#{ schema_directory }/#{ schema }.json"

    @issues = JSON::Validator.fully_validate(schema_path, json)
    @issues.empty?
  end

  failure_message do
    @issues.join("\n")
  end
end
