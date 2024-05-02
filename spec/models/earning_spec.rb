require 'rails_helper'

RSpec.describe Earning, type: :model do
  describe 'relationships' do
    it { is_expected.to belong_to(:employee).inverse_of(:earnings) }
  end
end
