require 'rails_helper'
RSpec.describe Country do
  subject { build(:country) } # Assuming you have FactoryBot set up for Country

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:alpha_two) }
    it { is_expected.to validate_presence_of(:alpha_three) }
    it { is_expected.to validate_presence_of(:country_code) }
    it { is_expected.to validate_presence_of(:nationality) }
    it { is_expected.to validate_presence_of(:continent) }
  end

  describe 'associations' do
    it { is_expected.to have_many(:currencies).dependent(:destroy) }
  end

  describe 'default scope' do
    it 'filters out deleted records' do
      deleted_country = create(:country, deleted: true)

      expect(described_class.all).not_to include(deleted_country)
    end
  end
end
