require 'rails_helper'

RSpec.describe Employee, type: :model do
  describe 'relationships' do
    it { is_expected.to have_many(:earnings).inverse_of(:employee).dependent(:destroy) }
  end
end
