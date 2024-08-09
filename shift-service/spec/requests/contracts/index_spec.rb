# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List contracts', type: :request do
  subject(:request) { get '/v1/contracts' }

  before { request }

  describe 'Search contracts without filters' do
    context 'when the request is valid' do
      include_examples 'expect specific HTTP status', :ok

      it { expect(response_body).to be_an(Array) }
      it { expect(response_body).to match_json_schema('v1/contracts') }
    end
  end
end
