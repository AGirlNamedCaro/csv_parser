class Layout < ApplicationRecord
  belongs_to :employer, inverse_of: :layout
end
