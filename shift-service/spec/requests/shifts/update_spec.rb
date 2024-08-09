# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Update shifts', type: :request do
  subject(:update_shift) { put "/v1/shifts/#{ shift_id }", params: }

  let(:shift) { shifts(:shift_two) }
  let(:shift_id) { shift.id }
  let(:engineer) { engineers(:base) }
  let(:params) { load_dynamic_json_symbolized('payload/shifts/update.json.erb', engineer_id: engineer.id) }

  context 'when the request is successful' do
    let(:engineer_shift) { engineers(:base) }
    let(:engineer) { engineers(:three) }

    before { update_shift }

    it 'responds with the updated shift' do
      expect(response).to have_http_status :ok
      expect(response_body[:id]).to eq shift.id
    end

    it 'matches the JSON schema' do
      expect(response_body).to match_json_schema('v1/shift')
    end
  end

  context 'when the shift does not exist' do
    let(:shift_id) { 'nonexistent-id' }

    before { update_shift }

    include_examples 'expect specific HTTP status', :not_found
  end

  context 'when the parameters are invalid' do
    context 'when engineer_shift attributes are invalid' do
      before do
        params[:engineer_shifts_attributes] = [
          {
            engineer_id: 'invalid-engineer-id'
          }
        ]
        update_shift
      end

      include_examples 'expect specific HTTP status', :unprocessable_entity

      it 'returns an error for engineer shifts' do
        expect(response_body.dig(:errors, 0, :attribute)).to include 'engineer_shifts.engineer'
        expect(response_body.dig(:errors, 0, :messages, 0, :description))
          .to include 'must exist'
      end
    end
  end
end
