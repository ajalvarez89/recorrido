# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Contracts::CreateService, type: :service do
  let(:id) { services(:base).id }
  let(:contract) { Contract.new }
  let(:payload) do
    load_dynamic_json_symbolized(
      'payload/contracts/create.json.erb',
      start_date: '2024-08-19',
      service_id: id
    )
  end

  subject(:service) { described_class.new(contract:, params: payload) }

  describe '#execute!' do
    it 'persists a new Contract in the database' do
      expect { subject.execute! }.to change(Contract, :count).by(1)
    end

    it 'returns true' do
      expect(subject.execute!).to be true
    end

    it 'builds the end date correctly' do
      subject.execute!
      expect(contract.end_date).to eq(contract.start_date + 6.days)
    end

    it 'publishes a ContractCreatedEvent' do
      expect(ContractCreatedEvent).to receive_message_chain(:new, :publish!)
      subject.execute!
    end

    context 'when the contract can\'t be persisted' do
      context 'with invalid start_date' do
        before { payload[:start_date] = nil }

        it 'raises ActiveRecord::RecordInvalid' do
          expect { service.execute! }.to raise_exception ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
