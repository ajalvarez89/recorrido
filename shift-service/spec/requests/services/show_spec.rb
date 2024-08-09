# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show a service', type: :request do
  let(:id) { services(:base).id }
  subject(:request) { get "/v1/services/#{ id }" }

  before { request }

  context 'when an existing service is requested' do
    include_examples 'expect specific HTTP status', :ok

    it { expect(response_body).to match_json_schema('v1/service') }
  end

  context 'when the service does not exist' do
    it_behaves_like 'returns a not_found HTTP status', '/v1/service/-1'
  end
end
