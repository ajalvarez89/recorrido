# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Engineer, type: :model do
  subject(:engineer) { engineers(:john) }

  describe 'Validations' do
    context 'validates attributes' do
      it { should validate_presence_of(:name) }
    end
  end
end
