# frozen_string_literal: true

RSpec.shared_examples 'returns a not_found HTTP status' do |url|
  subject(:request) { get url }

  it 'returns an not_found status' do
    request

    expect(response).to have_http_status :not_found
  end
end
