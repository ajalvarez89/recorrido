# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Show a shift', type: :request do
  let(:id) { shifts(:shift_one).id }
  subject(:request) { get "/v1/shifts/#{ id }" }

  before { request }

  context 'when an existing shift is requested' do
    include_examples 'expect specific HTTP status', :ok

    it { expect(response_body).to match_json_schema('v1/shift') }
  end

  context 'when the shift does not exist' do
    it_behaves_like 'returns a not_found HTTP status', '/v1/shift/-1'
  end
end
