# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Services::CreateService, type: :service do
  let(:service) { Service.new }
  let(:payload) { load_dynamic_json_symbolized('payload/services/create.json.erb') }

  subject(:service_create_service) { described_class.new(service:, params: payload) }

  describe '#execute!' do
    it 'persists a new Service in the database' do
      expect { subject.execute! }.to change(Service, :count).by(1)
    end

    it 'returns true' do
      expect(subject.execute!).to be true
    end

    context 'when the service can\'t be persisted' do
      context 'with invalid name' do
        before { payload[:name] = nil }

        it 'raises ActiveRecord::RecordInvalid' do
          expect { service_create_service.execute! }.to raise_exception ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
