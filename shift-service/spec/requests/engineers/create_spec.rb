# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Create engineers', type: :request do
  subject(:create_engineer) { post '/v1/engineers', params: }

  let(:engineer) { engineers(:base) }
  let(:params) { { name: 'John Doe' } }

  context 'when the request is successful' do
    it 'responds with the created engineer' do
      create_engineer

      expect(response).to have_http_status :created
      expect(response_body[:id]).not_to be_nil
      expect(response_body[:name]).to eq params[:name]
    end

    it 'matches the JSON schema' do
      create_engineer

      expect(response_body).to match_json_schema('v1/engineer')
    end
  end

  context 'when the name is already taken' do
    before do
      params[:name] = engineer.name
      create_engineer
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity

    it 'returns an email taken error' do
      expect(response_body[:errors].count).to be 1
      expect(response_body.dig(:errors, 0, :attribute)).to eq 'name'
      expect(response_body.dig(:errors, 0, :messages, 0, :description))
        .to include 'has already been taken'
    end
  end

  context 'when the name is missing' do
    before do
      params[:name] = nil
      create_engineer
    end

    include_examples 'expect specific HTTP status', :unprocessable_entity

    it 'returns a specific name blank error message' do
      expect(response_body.dig(:errors, 0, :attribute)).to include 'name'
      expect(response_body.dig(:errors, 0, :messages, 0, :description))
        .to include "can't be blank"
    end
  end
end
