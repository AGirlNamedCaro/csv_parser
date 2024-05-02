class Earning < ApplicationRecord
  belongs_to :employee, inverse_of: :earnings
end
