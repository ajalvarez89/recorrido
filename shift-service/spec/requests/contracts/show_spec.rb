# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show a contract', type: :request do
  let(:id) { contracts(:base).id }
  subject(:request) { get "/v1/contracts/#{ id }" }

  before { request }

  context 'when an existing contract is requested' do
    include_examples 'expect specific HTTP status', :ok

    it { expect(response_body).to match_json_schema('v1/contract') }
  end

  context 'when the contract does not exist' do
    it_behaves_like 'returns a not_found HTTP status', '/v1/contract/-1'
  end
end
