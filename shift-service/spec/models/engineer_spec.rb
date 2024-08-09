# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Engineer, type: :model do
  subject(:engineer) { engineers(:base) }

  describe 'Associations' do
    it { should have_many(:engineer_shifts).dependent(:destroy) }
    it { should have_many(:shifts).through(:engineer_shifts) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name).case_insensitive }
  end
end
