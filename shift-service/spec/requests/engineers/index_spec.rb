# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List engineers', type: :request do
  subject(:request) { get '/v1/engineers' }

  before { request }

  describe 'Search engineers without filters' do
    context 'when the request is valid' do
      include_examples 'expect specific HTTP status', :ok

      it { expect(response_body).to be_an(Array) }
      it { expect(response_body).to match_json_schema('v1/engineers') }
    end
  end
end
