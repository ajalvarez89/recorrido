# frozen_string_literal: true

RSpec.shared_examples 'expect specific HTTP status' do |status|
  it "validates the response with the #{ status } HTTP status" do
    expect(response).to have_http_status(status)
  end
end
