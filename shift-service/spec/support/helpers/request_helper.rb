# frozen_string_literal: true

module RequestHelper
  # Public: Returns the response body parsed according it own content type.
  def response_body
    case response.content_type
    when %r{^application/json}
      JSON.parse(response.body, symbolize_names: true)
    when %r{^application/xml}, %r{^text/xml}
      Nokogiri::XML(response.body)
    when %r{^text/html}
      Nokogiri::HTML(response.body)
    else
      response.body
    end
  end
end

RSpec.configure do |config|
  config.include RequestHelper
end
