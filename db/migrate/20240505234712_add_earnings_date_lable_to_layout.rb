class AddEarningsDateLableToLayout < ActiveRecord::Migration[7.1]
  def change
    add_column :layouts, :earning_date_label, :string
  end
end
