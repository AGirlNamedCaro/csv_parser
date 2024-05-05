require 'rails_helper'

RSpec.describe Employer, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:employees).inverse_of(:employer).dependent(:destroy) }
    it { is_expected.to have_one(:layout).inverse_of(:employer).dependent(:destroy)}
  end
end
