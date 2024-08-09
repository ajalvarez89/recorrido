# frozen_string_literal: true

require 'rails_helper'

RSpec.describe CreateShiftsWorker, type: :worker do
  include_examples 'worker', ['contract.created']
  subject(:worker) { described_class.new }

  let(:contract) { contracts(:contract_one) }

  let(:payload) { contract.to_json }

  before do
    allow(Shifts::CreateService).to receive(:new).and_call_original
  end

  describe '#work' do
    context 'when the payload is valid' do
      it 'creates shifts using Shifts::CreateService' do
        expect { worker.work(payload) }
          .to change { Shift.count }.by(53)
      end

      it 'acknowledges the message' do
        expect(worker).to receive(:ack!).and_call_original
        worker.work(payload)
      end
    end

    context 'when an error occurs' do
      before do
        allow_any_instance_of(Shifts::CreateService).to receive(:execute!).and_raise(StandardError)
      end

      it 'rejects the message' do
        expect(worker).to receive(:reject!).and_call_original
        worker.work(payload)
      end
    end

    context 'when the payload is malformed' do
      let(:malformed_payload) { 'invalid_json' }

      it 'rejects the message' do
        expect(worker).to receive(:reject!).and_call_original
        worker.work(malformed_payload)
      end
    end
  end
end
