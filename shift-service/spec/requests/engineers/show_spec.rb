# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show an engineer', type: :request do
  let(:id) { engineers(:base).id }
  subject(:request) { get "/v1/engineers/#{ id }" }

  before { request }

  context 'when an existing engineer is requested' do
    include_examples 'expect specific HTTP status', :ok

    it { expect(response_body).to match_json_schema('v1/engineer') }
  end

  context 'when the engineer does not exist' do
    it_behaves_like 'returns a not_found HTTP status', '/v1/engineer/-1'
  end
end
