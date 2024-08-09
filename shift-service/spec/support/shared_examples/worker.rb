# frozen_string_literal: true

RSpec.shared_examples 'worker' do |routing_keys|
  context 'worker configuration' do
    it 'has routing keys' do
      expect(described_class.new.opts[:routing_key]).to contain_exactly(*routing_keys)
    end
  end
end
