# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create contracts', type: :request do
  subject(:create_contract) { post '/v1/contracts', params: }

  let(:id) { services(:base).id }
  let(:contract) { Contract.new }
  let(:params) do
    load_dynamic_json_symbolized(
      'payload/contracts/create.json.erb',
      start_date: '2024-08-19',
      service_id: id
    )
  end

  context 'when the request is successful' do
    it 'responds with the created contract' do
      create_contract

      expect(response).to have_http_status :created
      expect(response_body[:id]).not_to be_nil
    end

    it 'matches the JSON schema' do
      create_contract

      expect(response_body).to match_json_schema('v1/contract')
    end
  end

  context 'when start_date is in the past' do
    before do
      params[:start_date] = '2020-01-01'
      create_contract
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity

    it 'returns a specific start_date error message' do
      expect(response_body.dig(:errors, 0, :attribute)).to include 'start_date'
      expect(response_body.dig(:errors, 0, :messages, 0, :description))
        .to include I18n.t('errors.messages.invalid_start_date', start_date: '2020-01-01 00:00:00 UTC')
    end
  end

  context 'when the contract start_date is missing' do
    before do
      params[:start_date] = nil
      create_contract
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity
  end
end
