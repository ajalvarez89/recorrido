# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create services', type: :request do
  subject(:create_service) { post '/v1/services', params: }
  let(:params) { load_dynamic_json_symbolized('payload/services/create.json.erb') }
  let(:service) { services(:base) }

  context 'when the request is successful' do
    it 'responds with the created service' do
      create_service

      expect(response).to have_http_status :created
      expect(response_body[:id]).not_to be_nil
      expect(response_body[:name]).to eq params[:name]
      expect(response_body[:description]).to eq params[:description]
    end

    it 'matches the JSON schema' do
      create_service

      expect(response_body).to match_json_schema('v1/service')
    end
  end

  context 'when the name is missing' do
    before do
      params[:name] = nil
      create_service
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity

    it 'returns a specific name blank error message' do
      expect(response_body.dig(:errors, 0, :attribute)).to include 'name'
      expect(response_body.dig(:errors, 0, :messages, 0, :description))
        .to include "can't be blank"
    end
  end

  context 'when the name already exists' do
    before do
      params[:name] = service.name
      create_service
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity

    it 'returns a name taken error' do
      expect(response_body[:errors].count).to be 1
      expect(response_body.dig(:errors, 0, :attribute)).to eq 'name'
      expect(response_body.dig(:errors, 0, :messages, 0, :description))
        .to include 'has already been taken'
    end
  end
end
