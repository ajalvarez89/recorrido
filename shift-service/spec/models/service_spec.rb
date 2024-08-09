# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  subject(:service) { services(:base) }

  describe 'Associations' do
    it { should have_many(:contracts).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
