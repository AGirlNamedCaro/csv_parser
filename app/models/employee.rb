class Employee < ApplicationRecord
  belongs_to :employer
  has_many :earnings, inverse_of: :employee, dependent: :destroy
end
