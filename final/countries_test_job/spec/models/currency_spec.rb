require 'rails_helper'
RSpec.describe Currency do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:alpha_two) }
    it { is_expected.to validate_presence_of(:currency_code) }
  end

  describe 'associations' do
    it { is_expected.to belong_to(:country) }
  end
end
