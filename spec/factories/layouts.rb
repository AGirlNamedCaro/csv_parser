FactoryBot.define do
  factory :layout do
    employer
    ext_ref_num_label { "MyString" }
    amount_label { "MyString" }
    earning_date_format { "MyString" }
    earning_date_label {"Some String"}
  end
end
