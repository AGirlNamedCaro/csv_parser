class CreateEarnings < ActiveRecord::Migration[7.1]
  def change
    create_table :earnings do |t|
      t.datetime :earning_date
      t.integer :amount_cents
      t.references :employee, null: false, foreign_key: true

      t.timestamps
    end
  end
end
