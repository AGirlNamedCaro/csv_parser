require 'rails_helper'

RSpec.describe Layout, type: :model do
  it {is_expected.to belong_to(:employer).inverse_of(:layout)}
end
