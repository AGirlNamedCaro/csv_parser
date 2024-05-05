class CreateLayouts < ActiveRecord::Migration[7.1]
  def change
    create_table :layouts do |t|
      t.references :employer, null: false, foreign_key: true
      t.string :ext_ref_num_label
      t.string :amount_label
      t.string :earning_date_label

      t.timestamps
    end
  end
end
