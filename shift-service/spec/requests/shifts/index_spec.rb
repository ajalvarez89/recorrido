# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'List shifts', type: :request do
  subject(:request) { get '/v1/shifts', params: }

  let(:params) {}

  before { request }

  describe 'Search shifts without filters' do
    context 'when the request is valid' do
      include_examples 'expect specific HTTP status', :ok

      it { expect(response_body).to be_an(Array) }
      it { expect(response_body).to match_json_schema('v1/shifts') }
    end
  end

  describe 'Search shifts with filters' do
    let(:params) { { by_date: '2024-08-12' } }

    it 'filters shifts by date' do
      expect(response_body).to all(include('date' => '2024-08-12'))
    end

    # Add more filter tests for by_day_of_week and by_contract
  end
end
