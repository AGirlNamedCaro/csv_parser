class Employer < ApplicationRecord
  has_many :employees, inverse_of: :employer, dependent: :destroy
end
