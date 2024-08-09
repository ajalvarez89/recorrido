# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Engineers::CreateService, type: :service do
  let(:engineer) { Engineer.new }
  let(:payload) { { name: 'John Doe' } }

  subject(:service) { described_class.new(engineer:, params: payload) }

  describe '#execute!' do
    it 'persists a new Engineer in the database' do
      expect { subject.execute! }.to change(Engineer, :count).by(1)
    end

    it 'returns true' do
      expect(subject.execute!).to be true
    end

    context 'when the engineer can\'t be persisted' do
      context 'with invalid name' do
        before { payload[:name] = nil }

        it 'raises ActiveRecord::RecordInvalid' do
          expect { service.execute! }.to raise_exception ActiveRecord::RecordInvalid
        end
      end
    end
  end
end
